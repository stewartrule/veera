import 'package:redux/redux.dart';

import '../util/http.dart';

import '../models/footwear_model.dart';
import '../reducers/root_reducer.dart';
import '../actions/footwear_actions.dart';

void fetchFootwear(
  Store<RootState> store,
  FetchFootwearAction action,
  NextDispatcher next,
) {
  next(action);

  http.get('/footwear').then((res) {
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

List<Middleware<RootState>> footwearMiddleware = [
  TypedMiddleware<RootState, FetchFootwearAction>(fetchFootwear),
];
