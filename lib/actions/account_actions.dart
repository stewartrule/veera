import '../models/account_model.dart';

class FetchAccountAction {}

class FetchAccountCompletedAction {
  AccountModel model;

  FetchAccountCompletedAction({this.model});
}
