import 'package:json_annotation/json_annotation.dart'
    show JsonSerializable, JsonKey;
import 'package:flutter/foundation.dart' show required;

import './footwear_variant_model.dart';
import './image_model.dart';

part 'footwear_model.g.dart';

@JsonSerializable(nullable: false)
class FootwearModel {
  final int id;
  final String name;
  final String description;
  final ImageModel image;
  final int price;
  @JsonKey(name: 'brand_id')
  final int brandId;
  @JsonKey(name: 'brand_name')
  final String brandName;
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'category_name')
  final String categoryName;
  @JsonKey(name: 'in_stock')
  final int inStock;
  @JsonKey(name: 'review_count')
  final int reviewCount;
  @JsonKey(nullable: false)
  final Map<dynamic, FootwearVariantModel> variants;
  @JsonKey(name: 'avg_rating')
  final int avgRating;

  FootwearModel({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.image,
    @required this.price,
    @required this.brandId,
    @required this.brandName,
    @required this.categoryId,
    @required this.categoryName,
    @required this.inStock,
    @required this.reviewCount,
    @required this.variants,
    @required this.avgRating,
  });

  factory FootwearModel.fromJson(Map<String, dynamic> json) =>
      _$FootwearModelFromJson(json);

  Map<String, dynamic> toJson() => _$FootwearModelToJson(this);
}
