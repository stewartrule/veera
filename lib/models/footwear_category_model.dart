import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'footwear_category_model.g.dart';

@JsonSerializable(nullable: false)
class FootwearCategoryModel {
  final int id;
  final String name;
  @JsonKey(name: 'product_count')
  final int productCount;

  FootwearCategoryModel({
    @required this.id,
    @required this.name,
    @required this.productCount,
  });

  factory FootwearCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$FootwearCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$FootwearCategoryModelToJson(this);
}
