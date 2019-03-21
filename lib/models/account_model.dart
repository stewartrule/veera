import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart' show required;

import './address_model.dart';
import './user_model.dart';

part 'account_model.g.dart';

@JsonSerializable(nullable: false)
class AccountModel {
  @JsonKey(nullable: true)
  final UserModel user;

  @JsonKey()
  final Map<dynamic, AddressModel> addresses;

  AccountModel({
    @required this.user,
    @required this.addresses,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);

  factory AccountModel.initialState() => AccountModel(
        addresses: Map(),
        user: null,
      );
}
