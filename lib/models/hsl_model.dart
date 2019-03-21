import 'dart:ui' show Color;
import 'package:flutter/painting.dart' show HSLColor;

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hsl_model.g.dart';

@JsonSerializable(nullable: false)
class HslModel {
  final int id;
  final double h;
  final double s;
  final double l;

  HslModel({
    @required this.id,
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

  factory HslModel.fromJson(Map<String, dynamic> json) =>
      _$HslModelFromJson(json);

  Map<String, dynamic> toJson() => _$HslModelToJson(this);

  @override
  String toString() {
    return getColor().toString();
  }
}
