import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/Colors.dart';

const apiBaseUrl = 'https://uzaar.eigix.net/api/';
const imgBaseUrl = 'https://uzaar.eigix.net/public/';

Future<http.Response> sendGetRequest(String action) {
  return http.get(Uri.parse(apiBaseUrl + action));
}

Future<http.Response> sendPostRequest(
    {required String action, required Map<String, String> data}) {
  print('action: $action');
  print('Map Payloads: $data');

  return http.post(
    Uri.parse(
      apiBaseUrl + action,
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );
}
