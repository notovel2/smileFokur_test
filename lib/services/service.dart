import 'package:flutter/foundation.dart';
import 'package:smile_fokus_test/constant/Config.dart';
import 'package:http/http.dart' as http;
class Service {
  static final rootUrl = "${Config.apiURl}${Config.apiPort}";
  static Future<http.Response> request({
    @required String path,
    Map<String, dynamic> body,
    Map<String, String> headers}) async{
    String url = "$rootUrl/$path";
    return http.post(
      url,
      body: body,
      headers: headers
    );
  }
}