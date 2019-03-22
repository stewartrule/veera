import 'package:flutter/foundation.dart' show required;
import 'package:json_annotation/json_annotation.dart'
    show JsonSerializable, JsonKey;

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
}
