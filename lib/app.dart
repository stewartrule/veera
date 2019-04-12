import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import './reducers/root_reducer.dart';

import './screens/account_screen.dart';
import './screens/footwear_screen.dart';
import './screens/footwear_categories_screen.dart';

import './app_config.dart';

class Routes {
  static const String Account = '/account';
  static const String Footwear = '/footwear';
  static const String FootwearCategories = '/';
}

class App extends StatelessWidget {
  final Store<RootState> store;

  App({
    Key key,
    this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);

    return new StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'RobotoCondensed'),
        title: config.title,
        initialRoute: Routes.FootwearCategories,
        routes: {
          Routes.FootwearCategories: (BuildContext context) =>
              FootwearCategoriesScreen(title: 'FOOTWEAR'),
          Routes.Account: (BuildContext context) =>
              AccountScreen(title: 'MENU'),
          Routes.Footwear: (BuildContext context) =>
              FootwearScreen(title: 'Footwear'),
        },
      ),
    );
  }
}
