import 'package:redux/redux.dart';

import '../util/http_client.dart';

import '../models/footwear_model.dart';
import '../reducers/root_reducer.dart';
import '../actions/footwear_actions.dart';

List<Middleware<RootState>> createFootwearMiddleware(HttpClient client) {
  void fetchFootwear(
    Store<RootState> store,
    FetchFootwearAction action,
    NextDispatcher next,
  ) {
    next(action);

    client.get('/footwear').then((res) {
      final data = res.map(
        (key, value) => MapEntry(
              key,
              FootwearModel.fromJson(value as Map<String, dynamic>),
            ),
      );

      return store.dispatch(
        FetchFootwearCompletedAction(data: data),
      );
    });
  }

  return [
    TypedMiddleware<RootState, FetchFootwearAction>(fetchFootwear),
  ];
}
