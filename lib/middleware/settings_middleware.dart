import 'package:redux/redux.dart';

import '../models/settings_model.dart';
import '../reducers/root_reducer.dart';
import '../actions/settings_actions.dart';

import '../util/http_client.dart';

List<Middleware<RootState>> createSettingsMiddleware(HttpClient client) {
  void fetchSettings(
    Store<RootState> store,
    FetchSettingsAction action,
    NextDispatcher next,
  ) {
    next(action);

    client.get('/settings').then((res) {
      return store.dispatch(
        FetchSettingsCompletedAction(
          model: SettingsModel.fromJson(res),
        ),
      );
    });
  }

  return [
    TypedMiddleware<RootState, FetchSettingsAction>(fetchSettings),
  ];
}
