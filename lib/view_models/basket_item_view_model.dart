import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../actions/basket_actions.dart';
import '../selectors/selectors.dart';
import '../reducers/root_reducer.dart';

import '../models/basket_model.dart';
import '../models/footwear_model.dart';
import '../models/footwear_variant_model.dart';
import '../models/footwear_size_model.dart';
import '../models/hsl_model.dart';

class BasketItemViewModel {
  final FootwearModel product;
  final Store<RootState> store;
  final BasketModel basket;
  final List<ExpandedFootwearVariantModel> variants;
  final List<FootwearModel> footwear;
  final List<HslModel> colors;
  final List<FootwearSizeModel> sizes;

  BasketItemViewModel({
    @required this.product,
    @required this.store,
    @required this.basket,
    @required this.variants,
    @required this.footwear,
    @required this.colors,
    @required this.sizes,
  });

  addFootwearVariant(FootwearVariantModel variant) {
    store.dispatch(BasketAddFootwearAction(amount: 1, variant: variant));
  }

  updateFootwear(FootwearVariantModel variant) {
    store.dispatch(BasketUpdateFootwearAction(amount: 1, variant: variant));
  }

  static BasketItemViewModel fromStore(
    Store<RootState> store,
    FootwearModel product,
  ) {
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

    return BasketItemViewModel(
      product: product,
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
