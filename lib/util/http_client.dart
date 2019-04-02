import 'package:http/http.dart' show Client;
import 'dart:async';
import 'dart:convert';

class HttpClient {
  Client client;
  String baseUrl;

  HttpClient({
    this.client,
    this.baseUrl,
  });

  Future<Map<String, dynamic>> get(String path) {
    return client
        .get("$baseUrl$path")
        .then((response) => json.decode(response.body))
        .then((res) => res['data']);
  }
}
