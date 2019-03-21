import 'package:flutter/foundation.dart' show required;

import '../models/account_model.dart';
import '../models/footwear_model.dart';
import '../models/settings_model.dart';

import './account_reducer.dart';
import './footwear_reducer.dart';
import './settings_reducer.dart';

class RootState {
  final SettingsModel settings;
  final AccountModel account;
  final Map<dynamic, FootwearModel> footwear;

  RootState({
    @required this.settings,
    @required this.account,
    @required this.footwear,
  });
}

RootState rootStateReducer(RootState state, action) => RootState(
      settings: settingsReducer(
        state.settings,
        action,
      ),
      account: accountReducer(
        state.account,
        action,
      ),
      footwear: footwearReducer(
        state.footwear,
        action,
      ),
    );
