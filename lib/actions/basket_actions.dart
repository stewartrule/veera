import 'package:flutter/foundation.dart' show required;

import '../models/basket_item_model.dart';
import '../models/footwear_model.dart';
import '../models/footwear_variant_model.dart';

class BasketAddFootwearAction {
  FootwearVariantModel variant;
  int amount;

  BasketAddFootwearAction({
    @required this.variant,
    @required this.amount,
  });
}

class BasketUpdateFootwearAction {
  FootwearVariantModel variant;
  int amount;

  BasketUpdateFootwearAction({
    @required this.variant,
    this.amount,
  });
}

class BasketRemoveFootwearVariantAction {
  FootwearVariantModel variant;

  BasketRemoveFootwearVariantAction({
    @required this.variant,
  });
}

class BasketRemoveFootwearAction {
  FootwearModel footwear;

  BasketRemoveFootwearAction({
    @required this.footwear,
  });
}

class BasketRemoveItemAction {
  BasketItemModel item;

  BasketRemoveItemAction({
    @required this.item,
  });
}
