import 'package:flutter/foundation.dart' show required;

import '../models/footwear_model.dart';
import '../models/brand_model.dart';
import '../models/account_model.dart';
import '../models/footwear_size_model.dart';
import '../models/hsl_model.dart';
import '../models/settings_model.dart';

import '../reducers/root_reducer.dart';

class ExpandedFootwearVariantModel {
  final int id;
  final FootwearModel footwear;
  final FootwearSizeModel size;
  final HslModel color;
  final int inStock;

  ExpandedFootwearVariantModel({
    @required this.id,
    @required this.footwear,
    @required this.size,
    @required this.color,
    @required this.inStock,
  });
}

List<ExpandedFootwearVariantModel> getFootwearVariantsByFootwearId(
  RootState state,
  int id,
) {
  FootwearModel footwear = getFootwearById(state, id);

  return footwear.variants.values.toList().map(
    (variant) {
      return ExpandedFootwearVariantModel(
        id: variant.id,
        inStock: variant.inStock,
        footwear: footwear,
        size: getFootwearSizeById(
          state,
          variant.sizeId,
        ),
        color: getColorById(
          state,
          variant.colorId,
        ),
      );
    },
  ).toList();
}

List<FootwearSizeModel> getFootwearSizes(RootState state) {
  return getSettings(state).footwearSizes.values.toList();
}

FootwearSizeModel getFootwearSizeById(RootState state, int id) {
  return getSettings(state).footwearSizes[id.toString()];
}

AccountModel getAccount(RootState state) {
  return state.account;
}

SettingsModel getSettings(RootState state) {
  return state.settings;
}

List<BrandModel> getFootwearBrands(RootState state) {
  return state.settings.footwearBrands.values.toList();
}

List<HslModel> getColors(RootState state) {
  return state.settings.colors.values.toList();
}

HslModel getColorById(RootState state, int id) {
  return state.settings.colors[id.toString()];
}

List<FootwearModel> getFootwear(RootState state) {
  return state.footwear.values.toList();
}

FootwearModel getFootwearById(RootState state, int id) {
  return state.footwear[id.toString()];
}
