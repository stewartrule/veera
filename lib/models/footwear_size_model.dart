import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'footwear_size_model.g.dart';

@JsonSerializable(nullable: false)
class FootwearSizeModel {
  final int id;
  final double us;
  final double eu;
  final double asia;

  FootwearSizeModel({
    @required this.id,
    @required this.us,
    @required this.eu,
    @required this.asia,
  });

  factory FootwearSizeModel.fromJson(Map<String, dynamic> json) =>
      _$FootwearSizeModelFromJson(json);

  Map<String, dynamic> toJson() => _$FootwearSizeModelToJson(this);
}
