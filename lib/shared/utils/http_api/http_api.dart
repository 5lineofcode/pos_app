

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

var httpApiWithCallback = HttpApi();

class HttpApi {
  static const Duration TIMEOUT_DURATION = Duration(seconds: 15);
  static const int LOCAL_TIMEOUT_STATUS_CODE = 608;
  static const int LOCAL_ERROR_STATUS_CODE = 600;

  Future<http.Response> get(
    String url,
    String apiUrl, {
    Map<String, String> headers,
    Map<String, String> params,
  }) async {
    var uri = Uri.https(url, apiUrl, params);
    return await http
        .get(uri, headers: headers)
        .timeout(TIMEOUT_DURATION, onTimeout: _defaultLocalTimeOutResponse)
        .then(_defaultResponse)
        .catchError(_defaultLocalErrorResponse);
  }

  Future<http.Response> post(
    String url,
    String apiUrl, {
    Map<String, String> headers,
    body,
    Encoding encoding,
    Map<String, String> params,
  }) async {
    var uri = Uri.https(url, apiUrl, params);
    return await http
        .post(uri, headers: headers, body: body, encoding: encoding)
        .timeout(TIMEOUT_DURATION, onTimeout: _defaultLocalTimeOutResponse)
        .then(_defaultResponse)
        .catchError(_defaultLocalErrorResponse);
  }

  Future<http.Response> delete(
    String url,
    String apiUrl, {
    Map<String, String> headers,
    Map<String, String> params,
  }) async {
    var uri = Uri.https(url, apiUrl, params);
    return await http
        .delete(uri, headers: headers)
        .timeout(TIMEOUT_DURATION, onTimeout: _defaultLocalTimeOutResponse)
        .then(_defaultResponse)
        .catchError(_defaultLocalErrorResponse);
  }

  Future<http.Response> _defaultResponse(http.Response response) {
    if (response.statusCode == HttpStatus.ok) {
      return Future.value(response);
    } else {
      return Future.error(response);
    }
  }

  Future<http.Response> _defaultLocalTimeOutResponse() {
    return Future.error(http.Response("", LOCAL_TIMEOUT_STATUS_CODE));
  }

  Future<http.Response> _defaultLocalErrorResponse(error) {
    if (error is http.Response) {
      return Future.error(error);
    } else {
      return Future.error(
          http.Response(error.toString(), LOCAL_ERROR_STATUS_CODE));
    }
  }
}
