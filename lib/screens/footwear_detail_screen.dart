import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:intl/intl.dart';

import '../widgets/cart_button.dart';
import '../widgets/cover_image.dart';
import '../widgets/color_checkbox.dart';
import '../widgets/size_select.dart';

import '../actions/basket_actions.dart';

import '../reducers/root_reducer.dart';

import '../models/basket_model.dart';
import '../models/footwear_model.dart';
import '../models/footwear_review_model.dart';

import '../view_models/basket_item_view_model.dart';

class FootwearDetailScreen extends StatelessWidget {
  final FootwearModel product;

  FootwearDetailScreen({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<RootState, BasketItemViewModel>(
        converter: (Store<RootState> store) {
          return BasketItemViewModel.fromStore(store, product);
        },
        builder: (
          BuildContext context,
          BasketItemViewModel vm,
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
                  backgroundColor: Colors.white,
                  // expandedHeight: 400,
                  // backgroundColor: product.image.getColor().withAlpha(128),
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  // flexibleSpace: FlexibleSpaceBar(
                  //   background: Stack(
                  //     fit: StackFit.expand,
                  //     children: <Widget>[
                  //       CoverImage(
                  //         image: product.image,
                  //         width: double.infinity,
                  //         height: 400,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  actions: <Widget>[
                    CartButton(color: Colors.black),
                    SizedBox(width: 16),
                  ],
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 24),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Rating(rating: product.avgRating),
                              Text(product.avgRating.toString()),
                              QuickAddButton(
                                footwear: product,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Stack(
                                children: <Widget>[
                                  CoverImage(
                                    image: product.image,
                                    width: double.infinity,
                                    height: 280,
                                  ),
                                  Positioned(
                                    child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                      ),
                                    ),
                                    bottom: 0,
                                    left: 0,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CoverImage(
                                  image: product.image,
                                  width: 64,
                                  height: 64,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                CoverImage(
                                  image: product.image,
                                  width: 64,
                                  height: 64,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                CoverImage(
                                  image: product.image,
                                  width: 64,
                                  height: 64,
                                ),
                              ],
                            )
                          ],
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
                        padding: EdgeInsets.fromLTRB(24, 0, 24, 16),
                        child: Text(
                          'Select Color',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      ),
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
                        padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
                        child: Text(
                          'Select Size',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(24, 8, 0, 0),
                        child: SizeSelect(
                          product: product,
                          vm: vm,
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
                          'Reviews',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      ),
                      HorizontalReviewList(
                        itemWidth: 256,
                        reviews: product.reviews.values.toList(),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                        child: Text(
                          'You may also like',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      ),
                      HorizontalProductList(
                        footwear: vm.footwear
                            .where((prod) => prod.id != product.id)
                            .where((prod) => prod.price > 5000)
                            .toList(),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                        child: Text(
                          'On sale',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      ),
                      HorizontalProductList(
                        footwear: vm.footwear
                            .where((prod) => prod.id != product.id)
                            .where((prod) => prod.price < 5000)
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

class Rating extends StatelessWidget {
  final double rating;

  const Rating({
    Key key,
    @required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [1, 2, 3, 4, 5].map(
        (r) {
          return Container(
            padding: EdgeInsets.all(0),
            child: Icon(
              Icons.star,
              color:
                  r <= rating.round() ? Colors.yellow.shade700 : Colors.black,
            ),
            // onPressed: () {},
          );
        },
      ).toList(),
    );
  }
}

class HorizontalProductList extends StatelessWidget {
  final List<FootwearModel> footwear;
  final double itemWidth;
  final double itemHeight;
  final double spacing;

  const HorizontalProductList({
    Key key,
    @required this.footwear,
    this.itemWidth = 160,
    this.itemHeight = 220,
    this.spacing = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight * 1.6,
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
                      height: itemHeight * 1.6,
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

class HorizontalReviewList extends StatelessWidget {
  final List<FootwearReviewModel> reviews;
  final double itemWidth;
  final double itemHeight;
  final double spacing;

  const HorizontalReviewList({
    Key key,
    @required this.reviews,
    this.itemWidth = 192,
    this.itemHeight = 160,
    this.spacing = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat('yyyy-MM-dd');

    return Container(
      height: itemHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: reviews
            .asMap()
            .map(
              (index, review) => MapEntry(
                    index,
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xffeeeeee),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(
                        left: index == 0 ? 24 : spacing,
                        right: index == reviews.length - 1 ? 24 : 0,
                      ),
                      width: itemWidth,
                      height: itemHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                review.title,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                formatter.format(review.createdAt),
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Rating(
                            rating: review.rating.toDouble(),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            review.description,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
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

              // showBottomCartSheet(context, vm.basket.items.length);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: inBasket ? Color(0xff037E7C) : Color(0xfffc8183),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8,
            ),
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
