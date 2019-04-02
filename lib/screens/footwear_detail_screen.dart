import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../actions/basket_actions.dart';

import '../selectors/selectors.dart';
import '../reducers/root_reducer.dart';

import '../models/basket_model.dart';
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
  FootwearDetailScreen({Key key, this.product}) : super(key: key);

  final FootwearModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xfffc8183),
        ),
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.close),
        ),
        actions: <Widget>[
          Icon(
            Icons.shopping_cart,
            color: Color(0xffaaaaaa),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: StoreConnector<RootState, _ViewModel>(
        converter: (Store<RootState> store) {
          return _ViewModel.fromStore(store, product);
        },
        builder: (
          BuildContext context,
          _ViewModel vm,
        ) {
          return Container(
            child: CustomScrollView(
              slivers: <Widget>[
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
                        Text(product.price.toString()),
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
                                (color) => Container(
                                      margin: EdgeInsets.only(right: 8),
                                      color: color.getColor(),
                                      width: 40,
                                      height: 40,
                                    ),
                              )
                              .toList(),
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
                        footwear: vm.footwear,
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
                          Container(
                            width: itemWidth,
                            height: itemHeight,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/pexels-photo-296881.jpg',
                                ),
                              ),
                            ),
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
            inBasket ? vm.remove() : vm.add();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8,
            ),
            color: inBasket ? Colors.deepOrange : Color(0xfffc8183),
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
