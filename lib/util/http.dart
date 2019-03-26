import 'package:http/http.dart' show Client;
import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

String domain =
    Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';

class _HttpClient {
  Client client;

  _HttpClient(this.client);

  Future<Map<String, dynamic>> get(String path) {
    return client
        .get("$domain$path")
        .then((response) => json.decode(response.body))
        .then((res) => res['data']);
  }
}

_HttpClient http = _HttpClient(Client());
