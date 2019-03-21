import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand_model.g.dart';

@JsonSerializable(nullable: false)
class BrandModel {
  final int id;
  final String name;
  @JsonKey(name: 'product_count')
  final int productCount;

  BrandModel({
    @required this.id,
    @required this.name,
    @required this.productCount,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) =>
      _$BrandModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrandModelToJson(this);
}
