import 'package:flutter/foundation.dart' show required;

import './footwear_variant_model.dart';

class BasketItemModel {
  final FootwearVariantModel variant;
  final int amount;

  BasketItemModel({
    @required this.variant,
    @required this.amount,
  });

  BasketItemModel copyWith({
    FootwearVariantModel variant,
    int amount,
  }) {
    return BasketItemModel(
      variant: variant ?? this.variant,
      amount: amount ?? this.amount,
    );
  }
}
