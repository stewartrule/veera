import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:ui' show Color;
import 'package:flutter/painting.dart' show HSLColor;

part 'image_model.g.dart';

@JsonSerializable(nullable: false)
class ImageModel {
  final int id;
  final String src;
  final double h;
  final double s;
  final double l;

  ImageModel({
    @required this.id,
    @required this.src,
    @required this.h,
    @required this.s,
    @required this.l,
  });

  HSLColor getHslColor() {
    return HSLColor.fromAHSL(1, h, s / 100, l / 100);
  }

  Color getColor() {
    return getHslColor().toColor();
  }

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}
