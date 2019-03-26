import 'package:redux/redux.dart';

import './util/http_client.dart';

import './middleware/account_middleware.dart';
import './middleware/footwear_middleware.dart';
import './middleware/settings_middleware.dart';

import './actions/account_actions.dart';
import './actions/footwear_actions.dart';
import './actions/settings_actions.dart';

import './models/account_model.dart';
import './models/settings_model.dart';

import './reducers/root_reducer.dart';

Store<RootState> createStore(HttpClient client) {
  final store = new Store<RootState>(
    rootStateReducer,
    middleware: []
      ..addAll(createAccountMiddleware(client))
      ..addAll(createSettingsMiddleware(client))
      ..addAll(createFootwearMiddleware(client)),
    initialState: RootState(
      account: AccountModel.initialState(),
      settings: SettingsModel.initialState(),
      footwear: Map(),
    ),
  );

  store.dispatch(FetchAccountAction());
  store.dispatch(FetchSettingsAction());
  store.dispatch(FetchFootwearAction());

  return store;
}
