import 'package:redux/redux.dart';

import '../actions/account_actions.dart';
import '../models/account_model.dart';

AccountModel updateAccountReducer(
  AccountModel old,
  FetchAccountCompletedAction action,
) {
  return action.model;
}

Reducer<AccountModel> accountReducer = combineReducers([
  TypedReducer<AccountModel, FetchAccountCompletedAction>(
    updateAccountReducer,
  ),
]);
