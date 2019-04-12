import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../widgets/cart_button.dart';
import '../widgets/cover_image.dart';

import '../actions/basket_actions.dart';

import '../selectors/selectors.dart';
import '../reducers/root_reducer.dart';

import '../models/basket_model.dart';
import '../models/basket_item_model.dart';
import '../models/footwear_model.dart';
import '../models/footwear_variant_model.dart';
import '../models/footwear_size_model.dart';
import '../models/hsl_model.dart';

class _ViewModel {
  final Store<RootState> store;
  final BasketModel basket;
  final List<ExpandedFootwearVariantModel> variants;
  final List<FootwearModel> footwear;
  final List<HslModel> colors;
  final List<FootwearSizeModel> sizes;

  _ViewModel({
    this.store,
    this.basket,
    this.variants,
    this.footwear,
    this.colors,
    this.sizes,
  });

  addFootwearVariant(FootwearVariantModel variant) {
    store.dispatch(BasketAddFootwearAction(amount: 1, variant: variant));
  }

  updateFootwear(FootwearVariantModel variant) {
    store.dispatch(BasketUpdateFootwearAction(amount: 1, variant: variant));
  }

  static _ViewModel fromStore(Store<RootState> store, FootwearModel product) {
    var variants = getFootwearVariantsByFootwearId(
      store.state,
      product.id,
    );

    List<HslModel> colors = variants
        .asMap()
        .map((i, variant) => MapEntry(variant.color.id, variant.color))
        .values
        .toList();

    List<FootwearSizeModel> sizes = variants
        .asMap()
        .map((i, variant) => MapEntry(variant.size.id, variant.size))
        .values
        .toList();

    return _ViewModel(
      basket: store.state.basket,
      store: store,
      colors: colors,
      sizes: sizes,
      variants: variants,
      footwear: store.state.footwear.values
          .where((model) => model.categoryId == product.categoryId)
          .toList(),
    );
  }
}

class FootwearDetailScreen extends StatelessWidget {
  final FootwearModel product;

  FootwearDetailScreen({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<RootState, _ViewModel>(
        converter: (Store<RootState> store) {
          return _ViewModel.fromStore(store, product);
        },
        builder: (
          BuildContext context,
          _ViewModel vm,
        ) {
          return Container(
            color: Colors.white,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  snap: false,
                  forceElevated: false,
                  elevation: 1,
                  floating: true,
                  expandedHeight: 400,
                  backgroundColor: product.image.getColor().withAlpha(128),
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        CoverImage(
                          image: product.image,
                          width: double.infinity,
                          height: 400,
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    CartButton(color: Colors.white),
                    SizedBox(width: 16),
                  ],
                ),
                SliverPadding(
                  padding: EdgeInsets.all(24),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Text(
                          product.name.toUpperCase(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "\$${product.price / 100}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(0xff777777),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              QuickAddButton(
                                footwear: product,
                              ),
                            ],
                          ),
                        ),
                        Text(product.description),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: EdgeInsets.only(left: 24),
                        child: Row(
                          children: vm.colors
                              .map(
                                (color) => ColorCheckbox(
                                      product: product,
                                      color: color,
                                      vm: vm,
                                    ),
                              )
                              .toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(24, 16, 0, 0),
                        child: Row(
                          children: []
                            ..add(
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 4, 4, 4),
                                child: Text(
                                  'SIZE',
                                ),
                              ),
                            )
                            ..addAll(
                              vm.sizes.map(
                                (size) => GestureDetector(
                                      onTap: () {
                                        var item = vm.basket.items.firstWhere(
                                          (item) =>
                                              item.variant.footwearId ==
                                              product.id,
                                          orElse: null,
                                        );

                                        var variant =
                                            product.variants.values.firstWhere(
                                          (variant) =>
                                              variant.sizeId == size.id &&
                                              (item is BasketItemModel
                                                  ? item.variant.colorId ==
                                                      variant.colorId
                                                  : true),
                                        );

                                        vm.updateFootwear(variant);
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(4, 4, 4, 4),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: vm.basket.items.any(
                                              (item) =>
                                                  item.variant.sizeId ==
                                                      size.id &&
                                                  item.variant.footwearId ==
                                                      product.id,
                                            )
                                                ? Colors.grey
                                                : Colors.white,
                                          ),
                                        ),
                                        child: Text(size.eu.toString()),
                                      ),
                                    ),
                              ),
                            )
                            ..toList(),
                        ),
                      )
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                        child: Text(
                          'MATCH WITH',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      ),
                      HorizontalList(
                        footwear: vm.footwear
                            .where((prod) => prod.id != product.id)
                            .toList(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class ColorCheckbox extends StatelessWidget {
  const ColorCheckbox({
    Key key,
    this.margin = const EdgeInsets.only(right: 8),
    @required this.color,
    @required this.product,
    @required this.vm,
  }) : super(key: key);

  final EdgeInsets margin;
  final FootwearModel product;
  final HslModel color;
  final _ViewModel vm;

  @override
  Widget build(BuildContext context) {
    var canSelect = vm.basket.hasFootwearWithId(product.id);

    return InkWell(
      onTap: () {
        var item = vm.basket.items.firstWhere(
          (item) => item.variant.footwearId == product.id,
          orElse: null,
        );

        var variant = product.variants.values.firstWhere(
          (variant) =>
              variant.colorId == color.id &&
              (item is BasketItemModel
                  ? item.variant.sizeId == variant.sizeId
                  : true),
        );

        if (variant is FootwearVariantModel) {
          vm.updateFootwear(variant);
        }
      },
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          border: Border.all(color: color.getColor(), width: 1),
          color: canSelect ? color.getColor() : Color(0xffffff),
        ),
        width: 40,
        height: 40,
        child: vm.basket.items.any(
          (item) =>
              item.variant.colorId == color.id &&
              item.variant.footwearId == product.id,
        )
            ? Icon(
                Icons.check,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}

class HorizontalList extends StatelessWidget {
  final List<FootwearModel> footwear;
  final double itemWidth;
  final double itemHeight;
  final double spacing;

  const HorizontalList({
    Key key,
    @required this.footwear,
    this.itemWidth = 160,
    this.itemHeight = 220,
    this.spacing = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight * 2,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: footwear
            .asMap()
            .map(
              (index, product) => MapEntry(
                    index,
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(
                        left: index == 0 ? 24 : spacing,
                        right: index == footwear.length - 1 ? 24 : 0,
                      ),
                      width: itemWidth,
                      height: itemHeight * 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            child: CoverImage(
                              image: product.image,
                              width: itemWidth,
                              height: itemHeight,
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FootwearDetailScreen(product: product),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Flexible(
                            child: Text(
                              product.name.toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "\$${(product.price / 100).toString()}",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          QuickAddButton(
                            footwear: product,
                          )
                        ],
                      ),
                    ),
                  ),
            )
            .values
            .toList(),
      ),
    );
  }
}

class _QuickAddButtonViewModel {
  final Store<RootState> store;
  final BasketModel basket;
  final FootwearModel footwear;

  _QuickAddButtonViewModel({
    this.store,
    this.footwear,
    this.basket,
  });

  void add() {
    store.dispatch(
      BasketAddFootwearAction(
        variant: footwear.variants.values.toList()[0],
        amount: 1,
      ),
    );
  }

  void remove() {
    store.dispatch(
      BasketRemoveFootwearAction(
        footwear: footwear,
      ),
    );
  }

  bool inBasket() {
    return basket.hasFootwearWithId(footwear.id);
  }

  static _QuickAddButtonViewModel fromStore(
    Store<RootState> store,
    FootwearModel footwear,
  ) {
    return _QuickAddButtonViewModel(
      footwear: footwear,
      store: store,
      basket: store.state.basket,
    );
  }
}

class QuickAddButton extends StatelessWidget {
  final FootwearModel footwear;

  QuickAddButton({
    Key key,
    this.footwear,
  }) : super(key: key);

  void showBottomCartSheet(BuildContext context, int count) {
    TextStyle style = TextStyle(color: Colors.white);

    showBottomSheet(
      context: context,
      builder: (context) {
        return new Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          color: Color(0xff333333),
          child: new GestureDetector(
            onVerticalDragDown: (details) {
              // todo: find better way to close sheet
              // while also closing the page
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'The item is added to the cart'.toUpperCase(),
                  style: style,
                ),
                Text(
                  'View all ($count)'.toUpperCase(),
                  style: style,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<RootState, _QuickAddButtonViewModel>(
      converter: (Store<RootState> store) {
        return _QuickAddButtonViewModel.fromStore(
          store,
          footwear,
        );
      },
      builder: (
        BuildContext context,
        _QuickAddButtonViewModel vm,
      ) {
        bool inBasket = vm.inBasket();

        return InkWell(
          onTap: () {
            if (inBasket) {
              vm.remove();
            } else {
              vm.add();

              showBottomCartSheet(context, vm.basket.items.length);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8,
            ),
            color: inBasket ? Color(0xff037E7C) : Color(0xfffc8183),
            child: Text(
              inBasket ? 'REMOVE' : 'ADD TO CART',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
