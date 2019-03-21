import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable(nullable: false)
class AddressModel {
  final int id;
  final String city;
  final String street;
  @JsonKey(name: 'zip_code')
  final String zipCode;
  final String state;

  AddressModel({
    @required this.id,
    @required this.city,
    @required this.street,
    @required this.zipCode,
    @required this.state,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
