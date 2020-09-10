import 'dart:async';
import 'package:pos_app/core.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as httpx;
import 'package:query_params/query_params.dart';

import 'http_temporary_handler.dart';

class ExtremeHttp {
  static String sessionId = "Unknown";
  static dynamic onBranchedEndpoint;
  static dynamic onUndefinedError;

  static dynamic onConnectTimeout;
  static dynamic onSendTimeout;
  static dynamic onReceiveTimeout;
  static dynamic onInternetConnectionProblem;
  static List<Map<String, dynamic>> httpLogs = [];

  static int timeoutInterval = 60 * 1000;

  static bool inDevelopmentMode = false;

  BuildContext httpContext;

  int maxRetryCount = 3;

  Future<dynamic> get(
    String url, {
    Map<String, dynamic> params,
    Map<String, String> headers,
    bool isCached = false,
    dynamic onSocketException,
    bool disableLog = false,
    onRequestTimeout,
  }) async {
    var returnedResponse;

    URLQueryParams queryParams = URLQueryParams();
    if (params != null) {
      params.forEach((key, value) {
        queryParams.append(key, value);
      });
    }

    var targetUrl =
        url + (queryParams.toString().isNotEmpty ? "?$queryParams" : "");

    var httpLog = {
      "method": "GET",
      "url": url,
      "params": params,
      "created_at": DateTime.now(),
    };

    try {
      var response = await httpx
          .get(
            targetUrl,
            headers: headers,
          )
          .timeout(Duration(milliseconds: timeoutInterval));

      
      await HttpTemporaryHandler.handle(url, "GET", response);

      httpLog["closed_at"] = DateTime.now();
      httpLog["status"] = "OK";
      httpLog["ms"] = DateTime.parse(httpLog["closed_at"].toString())
          .difference(httpLog["created_at"])
          .inMilliseconds;
      httpLogs.add(httpLog);

      try {
        debugPrint(response.body);
        var body = utf8.decode(response.bodyBytes);
        returnedResponse = jsonDecode(body);
      } on Exception catch (_) {
        returnedResponse = [];
      }
    } on SocketException catch (_) {
      debugPrint("SocketException");

      
      await HttpTemporaryHandler.spesificHandle(url, "GET", "SocketException");
    } on TimeoutException catch (_) {
      debugPrint("TimeoutException");

      
      await HttpTemporaryHandler.spesificHandle(url, "GET", "TimeoutException");
    } on Exception catch (_) {
      debugPrint("Catch Exception");

      
      await HttpTemporaryHandler.spesificHandle(url, "GET", "Undefined");
    }

    return Future.value(returnedResponse);
  }

  Future<dynamic> post(
    String url, {
    dynamic postData,
    Map<String, String> headers = const {},
    dynamic onSocketException,
    bool disableLog = false,
  }) async {
    var returnedResponse;

    try {
      var response = await httpx
          .post(
            url,
            headers: headers,
            body: postData,
          )
          .timeout(Duration(milliseconds: timeoutInterval));

      
      await HttpTemporaryHandler.handle(url, "GET", response);

      try {
        returnedResponse = json.decode(response.body);
      } on Exception catch (_) {
        returnedResponse = [];
      }
    } on SocketException catch (_) {
      debugPrint("SocketException");

      
      await HttpTemporaryHandler.spesificHandle(url, "POST", "SocketException");
    } on TimeoutException catch (_) {
      debugPrint("TimeoutException");

      
      await HttpTemporaryHandler.spesificHandle(
          url, "POST", "TimeoutException");
    } on Exception catch (_) {
      debugPrint("Catch Exception");

      
      await HttpTemporaryHandler.spesificHandle(url, "POST", "Undefined");
    }

    return Future.value(returnedResponse);
  }

  Future<dynamic> delete(
    String url, {
    dynamic params = const {},
    Map<String, String> headers = const {},
    dynamic onSocketException,
    bool disableLog = false,
  }) async {
    var returnedResponse;

    try {
      URLQueryParams queryParams = URLQueryParams();
      if (params != null) {
        params.forEach((key, value) {
          queryParams.append(key, value);
        });
      }

      var targetUrl =
          url + (queryParams.toString().isNotEmpty ? "?$queryParams" : "");

      var response = await httpx
          .delete(
            targetUrl,
            headers: headers,
          )
          .timeout(Duration(milliseconds: timeoutInterval));

      
      await HttpTemporaryHandler.handle(url, "DELETE", response);

      try {
        returnedResponse = jsonDecode(response.body);
      } on Exception catch (_) {
        returnedResponse = [];
      }
    } on SocketException catch (_) {
      debugPrint("SocketException");

      
      await HttpTemporaryHandler.spesificHandle(
          url, "DELETE", "SocketException");
    } on TimeoutException catch (_) {
      debugPrint("TimeoutException");

      
      await HttpTemporaryHandler.spesificHandle(
          url, "DELETE", "TimeoutException");
    } on Exception catch (_) {
      debugPrint("Catch Exception");

      
      await HttpTemporaryHandler.spesificHandle(url, "DELETE", "Undefined");
    }
    return Future.value(returnedResponse);
  }
}

var http = ExtremeHttp();
