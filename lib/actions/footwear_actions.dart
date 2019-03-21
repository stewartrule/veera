import '../models/footwear_model.dart';

class FetchFootwearAction {}

class FetchFootwearCompletedAction {
  Map<dynamic, FootwearModel> data;

  FetchFootwearCompletedAction({this.data});
}
