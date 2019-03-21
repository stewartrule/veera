import 'package:redux/redux.dart';

import '../actions/footwear_actions.dart';
import '../models/footwear_model.dart';

Map<dynamic, FootwearModel> updateFootwearReducer(
  Map<dynamic, FootwearModel> state,
  FetchFootwearCompletedAction action,
) {
  return Map()..addAll(state)..addAll(action.data);
}

Reducer<Map<dynamic, FootwearModel>> footwearReducer = combineReducers([
  TypedReducer<Map<dynamic, FootwearModel>, FetchFootwearCompletedAction>(
    updateFootwearReducer,
  ),
]);
