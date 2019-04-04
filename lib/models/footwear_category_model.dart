import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import './image_model.dart';

part 'footwear_category_model.g.dart';

@JsonSerializable(nullable: false)
class FootwearCategoryModel {
  final int id;
  final String name;
  final ImageModel image;
  @JsonKey(name: 'product_count')
  final int productCount;

  FootwearCategoryModel({
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.productCount,
  });

  factory FootwearCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$FootwearCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$FootwearCategoryModelToJson(this);
}
