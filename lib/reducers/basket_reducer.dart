import 'package:redux/redux.dart';
import '../actions/basket_actions.dart';
import '../models/basket_model.dart';

BasketModel _addFootwearVariantReducer(
  BasketModel basket,
  BasketAddFootwearAction action,
) =>
    basket.addFootwear(
      variant: action.variant,
      amount: action.amount,
    );

BasketModel _updateFootwearVariantReducer(
  BasketModel basket,
  BasketUpdateFootwearAction action,
) =>
    basket.updateFootwear(
      variant: action.variant,
      amount: action.amount,
    );

BasketModel _removeFootwearReducer(
  BasketModel basket,
  BasketRemoveFootwearAction action,
) =>
    basket.removeFootwear(action.footwear);

BasketModel _removeFootwearVariantReducer(
  BasketModel basket,
  BasketRemoveFootwearVariantAction action,
) =>
    basket.removeFootwearVariant(action.variant);

BasketModel _removeItemReducer(
  BasketModel basket,
  BasketRemoveItemAction action,
) =>
    basket.removeItem(action.item);

BasketModel _updateFootwearReducer(
  BasketModel basket,
  BasketUpdateFootwearAction action,
) =>
    basket.updateFootwear(
      variant: action.variant,
      amount: 1,
    );

Reducer<BasketModel> basketReducer = combineReducers([
  TypedReducer<BasketModel, BasketAddFootwearAction>(
    _addFootwearVariantReducer,
  ),
  TypedReducer<BasketModel, BasketUpdateFootwearAction>(
    _updateFootwearVariantReducer,
  ),
  TypedReducer<BasketModel, BasketRemoveFootwearVariantAction>(
    _removeFootwearVariantReducer,
  ),
  TypedReducer<BasketModel, BasketRemoveFootwearAction>(
    _removeFootwearReducer,
  ),
  TypedReducer<BasketModel, BasketRemoveItemAction>(
    _removeItemReducer,
  ),
  TypedReducer<BasketModel, BasketUpdateFootwearAction>(
    _updateFootwearReducer,
  ),
]);
