import '../models/settings_model.dart';

class FetchSettingsAction {}

class FetchSettingsCompletedAction {
  SettingsModel model;

  FetchSettingsCompletedAction({this.model});
}
