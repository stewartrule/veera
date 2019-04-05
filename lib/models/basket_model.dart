import 'package:flutter/foundation.dart' show required;

import './basket_item_model.dart';
import './footwear_variant_model.dart';
import './footwear_model.dart';

class BasketModel {
  final List<BasketItemModel> items;

  BasketModel({
    @required this.items,
  });

  bool hasFootwearWithId(int footwearId) {
    return items.any(
      (BasketItemModel basketItem) =>
          basketItem.variant.footwearId == footwearId,
    );
  }

  bool hasFootwearVariant(FootwearVariantModel variant) {
    return items.any(
      (BasketItemModel basketItem) => basketItem.variant.id == variant.id,
    );
  }

  BasketModel removeFootwear(FootwearModel footwear) {
    return copyWith(
      items: items
          .where(
            (BasketItemModel basketItem) =>
                basketItem.variant.footwearId != footwear.id,
          )
          .toList(),
    );
  }

  BasketModel removeFootwearVariant(FootwearVariantModel variant) {
    return copyWith(
      items: items
          .where(
            (BasketItemModel basketItem) => basketItem.variant.id != variant.id,
          )
          .toList(),
    );
  }

  BasketModel removeItem(BasketItemModel item) {
    return copyWith(
      items: items
          .where(
            (BasketItemModel basketItem) =>
                basketItem.variant.id != item.variant.id,
          )
          .toList(),
    );
  }

  BasketModel updateFootwear({
    @required FootwearVariantModel variant,
    int amount,
  }) {
    return copyWith(
      items: items
          .map(
            (BasketItemModel basketItem) =>
                basketItem.variant.footwearId == variant.footwearId
                    ? basketItem.copyWith(amount: amount, variant: variant)
                    : basketItem,
          )
          .toList(),
    );
  }

  BasketModel addFootwear({
    @required FootwearVariantModel variant,
    @required int amount,
  }) {
    return hasFootwearVariant(variant)
        ? this
        : copyWith(
            items: items
              ..add(
                BasketItemModel(
                  variant: variant,
                  amount: amount,
                ),
              ),
          );
  }

  BasketModel copyWith({
    @required List<BasketItemModel> items,
  }) {
    return BasketModel(
      items: items ?? this.items,
    );
  }
}
