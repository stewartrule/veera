import 'package:flutter/material.dart';

import '../models/basket_item_model.dart';
import '../models/footwear_model.dart';

import '../view_models/basket_item_view_model.dart';

class SizeSelect extends StatelessWidget {
  final FootwearModel product;
  final BasketItemViewModel vm;

  const SizeSelect({
    Key key,
    @required this.product,
    @required this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: []
        ..add(
          Padding(
            padding: EdgeInsets.fromLTRB(0, 4, 4, 4),
            child: Text(
              'SIZE',
            ),
          ),
        )
        ..addAll(
          vm.sizes.map(
            (size) => GestureDetector(
                  onTap: () {
                    var item = vm.basket.items.firstWhere(
                      (item) =>
                          item.variant.footwearId ==
                          product.id,
                      orElse: null,
                    );

                    var variant =
                        product.variants.values.firstWhere(
                      (variant) =>
                          variant.sizeId == size.id &&
                          (item is BasketItemModel
                              ? item.variant.colorId ==
                                  variant.colorId
                              : true),
                    );

                    vm.updateFootwear(variant);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.fromLTRB(4, 4, 4, 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: vm.basket.items.any(
                          (item) =>
                              item.variant.sizeId ==
                                  size.id &&
                              item.variant.footwearId ==
                                  product.id,
                        )
                            ? Colors.red
                            : Colors.white,
                      ),
                    ),
                    child: Text(size.eu.toString()),
                  ),
                ),
          ),
        )
        ..toList(),
    );
  }
}
