import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import './middleware/account_middleware.dart';
import './middleware/footwear_middleware.dart';
import './middleware/settings_middleware.dart';

import './actions/account_actions.dart';
import './actions/footwear_actions.dart';
import './actions/settings_actions.dart';

import './models/account_model.dart';
import './models/settings_model.dart';

import './reducers/root_reducer.dart';

import './screens/account_screen.dart';
import './screens/footwear_screen.dart';
import './screens/footwear_categories_screen.dart';

class Routes {
  // static const String Home = '/';
  static const String Account = '/account';
  static const String Footwear = '/footwear';
  static const String FootwearCategories = '/';
}

class StoreUIKit extends StatelessWidget {
  final Store<RootState> store;

  StoreUIKit({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'RobotoCondensed'),
        title: 'Store UI Kit',
        initialRoute: Routes.FootwearCategories,
        routes: {
          Routes.FootwearCategories: (BuildContext context) =>
              FootwearCategoriesScreen(title: 'Footwear Categories'),
          Routes.Account: (BuildContext context) =>
              AccountScreen(title: 'Account'),
          Routes.Footwear: (BuildContext context) =>
              FootwearScreen(title: 'Footwear'),
        },
      ),
    );
  }
}

void main() {
  final store = new Store<RootState>(
    rootStateReducer,
    middleware: []
      ..addAll(accountMiddleware)
      ..addAll(settingsMiddleware)
      ..addAll(footwearMiddleware),
    initialState: RootState(
      account: AccountModel.initialState(),
      settings: SettingsModel.initialState(),
      footwear: Map(),
    ),
  );

  store.dispatch(FetchAccountAction());
  store.dispatch(FetchSettingsAction());
  store.dispatch(FetchFootwearAction());

  runApp(new StoreUIKit(store: store));
}
