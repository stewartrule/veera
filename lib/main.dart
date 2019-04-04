import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;

import './app_config.dart';
import './app.dart';
import './create_store.dart';
import './util/http_client.dart';

void main() {
  String baseUrl =
      Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';

  HttpClient client = HttpClient(
    baseUrl: baseUrl,
    client: Client(),
  );

  final store = createStore(client);

  AppConfig app = AppConfig(
    client: client,
    cdnUrl: baseUrl,
    title: 'Dev',
    child: App(store: store),
  );

  runApp(app);
}
