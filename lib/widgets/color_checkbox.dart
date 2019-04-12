import 'package:flutter/material.dart';

import '../models/basket_item_model.dart';
import '../models/footwear_model.dart';
import '../models/footwear_variant_model.dart';
import '../models/hsl_model.dart';

import '../view_models/basket_item_view_model.dart';

class ColorCheckbox extends StatelessWidget {
  final EdgeInsets margin;
  final FootwearModel product;
  final HslModel color;
  final BasketItemViewModel vm;

  const ColorCheckbox({
    Key key,
    this.margin = const EdgeInsets.only(right: 8),
    @required this.color,
    @required this.product,
    @required this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var canSelect = vm.basket.hasFootwearWithId(product.id);

    return InkWell(
      onTap: () {
        var item = vm.basket.items.firstWhere(
          (item) => item.variant.footwearId == product.id,
          orElse: null,
        );

        var variant = product.variants.values.firstWhere(
          (variant) =>
              variant.colorId == color.id &&
              (item is BasketItemModel
                  ? item.variant.sizeId == variant.sizeId
                  : true),
        );

        if (variant is FootwearVariantModel) {
          vm.updateFootwear(variant);
        }
      },
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          border: Border.all(color: color.getColor(), width: 1),
          color: canSelect ? color.getColor() : Color(0xffffff),
        ),
        width: 32,
        height: 32,
        child: vm.basket.items.any(
          (item) =>
              item.variant.colorId == color.id &&
              item.variant.footwearId == product.id,
        )
            ? Icon(
                Icons.check,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
