import 'package:flutter/material.dart';
import 'dart:io' show Platform;

String baseUrl =
    Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';

NetworkImage cdnImage(String src) {
  return NetworkImage("$baseUrl/images/$src");
}
