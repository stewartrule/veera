import 'package:flutter/foundation.dart' show required;

import '../models/account_model.dart';
import '../models/basket_model.dart';
import '../models/footwear_model.dart';
import '../models/settings_model.dart';

import './account_reducer.dart';
import './basket_reducer.dart';
import './footwear_reducer.dart';
import './settings_reducer.dart';

class RootState {
  final AccountModel account;
  final BasketModel basket;
  final Map<dynamic, FootwearModel> footwear;
  final SettingsModel settings;

  RootState({
    @required this.account,
    @required this.basket,
    @required this.footwear,
    @required this.settings,
  });
}

RootState rootStateReducer(RootState state, action) => RootState(
      basket: basketReducer(
        state.basket,
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
      settings: settingsReducer(
        state.settings,
        action,
      ),
    );
