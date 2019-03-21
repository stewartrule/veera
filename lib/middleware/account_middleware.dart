import 'package:redux/redux.dart';

import '../models/account_model.dart';
import '../reducers/root_reducer.dart';
import '../actions/account_actions.dart';

import '../util/http.dart';

void fetchAccount(
  Store<RootState> store,
  FetchAccountAction action,
  NextDispatcher next,
) {
  next(action);

  http.get('/account').then((res) {
    return store.dispatch(
      FetchAccountCompletedAction(
        model: AccountModel.fromJson(res),
      ),
    );
  });
}

List<Middleware<RootState>> accountMiddleware = [
  TypedMiddleware<RootState, FetchAccountAction>(fetchAccount),
];
