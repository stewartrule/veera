import 'package:flutter/foundation.dart' show required;
import 'package:json_annotation/json_annotation.dart'
    show JsonSerializable, JsonKey;

// import '../reducers/root_reducer.dart';
// import '../models/hsl_model.dart';
// import '../models/footwear_size_model.dart';

part 'footwear_variant_model.g.dart';

@JsonSerializable(nullable: false)
class FootwearVariantModel {
  int id;
  @JsonKey(name: 'footwear_id')
  int footwearId;
  @JsonKey(name: 'size_id')
  int sizeId;
  @JsonKey(name: 'in_stock')
  int inStock;
  @JsonKey(name: 'color_id')
  int colorId;

  FootwearVariantModel({
    @required this.id,
    @required this.footwearId,
    @required this.sizeId,
    @required this.inStock,
    @required this.colorId,
  });

  factory FootwearVariantModel.fromJson(Map<String, dynamic> json) =>
      _$FootwearVariantModelFromJson(json);

  Map<String, dynamic> toJson() => _$FootwearVariantModelToJson(this);

  // FootwearSizeModel size(RootState state) {
  //   return state.settings.footwearSizes[sizeId];
  //   // return state.settings.footwearSizes.values
  //   //     .firstWhere((size) => size.id == sizeId);
  // }

  // HslModel color(RootState state) {
  //   return state.settings.colors[colorId];

  //   // return state.settings.colors.values
  //   //     .firstWhere((color) => color.id == colorId);
  // }
}

// /// Selectors
// class State {
//   Map<int, FootwearModel> footwear;
//   Map<int, HslModel> colors;
//   // List<HslModel> colors;
// }

// FootwearModel footwear(State state, int footwearId) {
//   return state.footwear[footwearId];
//   // .firstWhere((model) => model.id == footwearId);
// }

// HslModel color(State state, int colorId) {
//   return state.colors[colorId];
//   // return state.colors.firstWhere((model) => model.id == colorId);
// }
