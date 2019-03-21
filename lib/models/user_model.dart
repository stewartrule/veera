import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(nullable: false)
class UserModel {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String phone;
  final bool male;
  @JsonKey(name: 'footwear_size_id')
  final int footwearSizeId;
  @JsonKey(name: 'clothing_size_id')
  final int clothingSizeId;

  UserModel({
    @required this.id,
    @required this.firstname,
    @required this.lastname,
    @required this.email,
    @required this.phone,
    @required this.male,
    @required this.footwearSizeId,
    @required this.clothingSizeId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
