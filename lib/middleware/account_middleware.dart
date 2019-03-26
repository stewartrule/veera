import 'package:redux/redux.dart';

import '../models/account_model.dart';
import '../reducers/root_reducer.dart';
import '../actions/account_actions.dart';

import '../util/http_client.dart';

List<Middleware<RootState>> createAccountMiddleware(HttpClient client) {
  void fetchAccount(
    Store<RootState> store,
    FetchAccountAction action,
    NextDispatcher next,
  ) {
    next(action);

    client.get('/account').then((res) {
      return store.dispatch(
        FetchAccountCompletedAction(
          model: AccountModel.fromJson(res),
        ),
      );
    });
  }

  return [
    TypedMiddleware<RootState, FetchAccountAction>(fetchAccount),
  ];
}
