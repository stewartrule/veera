import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart' show required;

import './brand_model.dart';
import './footwear_category_model.dart';
import './footwear_size_model.dart';
import './hsl_model.dart';

part 'settings_model.g.dart';

@JsonSerializable(nullable: false)
class SettingsModel {
  @JsonKey()
  final Map<dynamic, BrandModel> footwearBrands;
  @JsonKey()
  final Map<dynamic, FootwearCategoryModel> footwearCategories;
  @JsonKey()
  final Map<dynamic, FootwearSizeModel> footwearSizes;
  @JsonKey()
  final Map<dynamic, HslModel> colors;

  SettingsModel({
    @required this.footwearBrands,
    @required this.footwearCategories,
    @required this.footwearSizes,
    @required this.colors,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);

  factory SettingsModel.initialState() => SettingsModel(
        colors: Map(),
        footwearBrands: Map(),
        footwearCategories: Map(),
        footwearSizes: Map(),
      );
}
