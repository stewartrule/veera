import 'package:redux/redux.dart';

import '../models/hsl_model.dart';
import '../models/footwear_model.dart';
import '../models/footwear_size_model.dart';
import '../models/footwear_variant_model.dart';
import '../reducers/root_reducer.dart';

class FootwearVariantViewModel {
  final FootwearVariantModel variant;
  final FootwearSizeModel size;
  final HslModel color;

  FootwearVariantViewModel({
    this.variant,
    this.size,
    this.color,
  });
}

class FootwearViewModel {
  Store<RootState> store;
  FootwearModel product;

  FootwearViewModel({
    this.store,
    this.product,
  });
}
