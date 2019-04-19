import 'package:json_annotation/json_annotation.dart'
    show JsonSerializable, JsonKey;
import 'package:flutter/foundation.dart' show required;

part 'footwear_review_model.g.dart';

@JsonSerializable(nullable: false)
class FootwearReviewModel {
  final int id;
  final String title;
  final String description;
  @JsonKey(name: 'user_id')
  final int userId;
  final int rating;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  FootwearReviewModel({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.userId,
    @required this.rating,
    @required this.createdAt,
  });

  factory FootwearReviewModel.fromJson(Map<String, dynamic> json) =>
      _$FootwearReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$FootwearReviewModelToJson(this);
}
