import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show required;
import './util/http_client.dart';

class AppConfig extends InheritedWidget {
  final HttpClient client;
  final String title;

  AppConfig({
    @required this.title,
    @required this.client,
    @required Widget child,
  }) : super(child: child);

  static AppConfig of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppConfig);
  }

  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
