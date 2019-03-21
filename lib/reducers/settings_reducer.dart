import 'package:redux/redux.dart';

import '../actions/settings_actions.dart';
import '../models/settings_model.dart';

SettingsModel updateSettingsReducer(
  SettingsModel _,
  FetchSettingsCompletedAction action,
) {
  return action.model;
}

Reducer<SettingsModel> settingsReducer = combineReducers([
  new TypedReducer<SettingsModel, FetchSettingsCompletedAction>(
    updateSettingsReducer,
  ),
]);
