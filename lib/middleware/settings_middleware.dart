import 'package:redux/redux.dart';

import '../models/settings_model.dart';
import '../reducers/root_reducer.dart';
import '../actions/settings_actions.dart';

import '../util/http.dart';

void fetchSettings(
  Store<RootState> store,
  FetchSettingsAction action,
  NextDispatcher next,
) {
  next(action);

  http.get('/settings').then((res) {
    return store.dispatch(
      FetchSettingsCompletedAction(
        model: SettingsModel.fromJson(res),
      ),
    );
  });
}

List<Middleware<RootState>> settingsMiddleware = [
  TypedMiddleware<RootState, FetchSettingsAction>(fetchSettings),
];
