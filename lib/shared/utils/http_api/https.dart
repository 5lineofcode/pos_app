import 'dart:async';
import 'package:pos_app/core.dart';
import 'package:query_params/query_params.dart';
import 'package:dio/dio.dart';

import 'https_error_handler.dart';

class HttpHelper {
  static int timeout = 60 * 1000;

  static getDefaultHeader() {
    if (AppSession.accessToken == null || AppSession.accessToken.length == 0) {
      AppSession.accessToken = "5afaa9a8-350f-42fa-a328-3f6c344d3fbf";
    }
    return {
      "Content-Type": "application/json",
      "X-Auth-Token": AppSession.accessToken.toString(),
    };
  }

  Future<ApiResponse> get(
    String url, {
    Map<String, dynamic> params,
    Map<String, String> headers,
  }) async {
    if (headers == null) {
      headers = getDefaultHeader();
    }

    URLQueryParams queryParams = URLQueryParams();
    if (params != null) {
      params.forEach((key, value) {
        queryParams.append(key, value);
      });
    }

    var targetUrl =
        url + (queryParams.toString().isNotEmpty ? "?$queryParams" : "");
    try {
      debugPrint(url);
      var response = await Dio()
          .get(
            targetUrl,
            options: Options(
              headers: headers,
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              },
            ),
          )
          .timeout(Duration(milliseconds: timeout));

      if (HttpErrorHandler.onFailedButHasData(response)) {
        return Future.value(ApiResponse(
          status: ApiStatus.failed,
          data: response.data,
        ));
      }

      return Future.value(HttpErrorHandler.onRequestSuccess(response));
    } on HandshakeException catch (e) {
      return HttpErrorHandler.onHandshakeException(e);
    } on DioError catch (e) {
      return HttpErrorHandler.onDioError(e);
    } on TimeoutException catch (e) {
      return HttpErrorHandler.onTimeout(e);
    }
  }

  Future<ApiResponse> post(
    String url, {
    dynamic postData,
    Map<String, String> headers,
  }) async {
    if (headers == null) {
      headers = getDefaultHeader();
    }

    try {
      debugPrint("Try to Post");
      var response = await Dio()
          .post(
            url,
            options: Options(
              headers: headers,
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              },
            ),
            data: postData,
          )
          .timeout(Duration(milliseconds: timeout));

      if (HttpErrorHandler.onFailedButHasData(response)) {
        return Future.value(ApiResponse(
          status: ApiStatus.failed,
          data: response.data,
        ));
      }

      return Future.value(HttpErrorHandler.onRequestSuccess(response));
    } on HandshakeException catch (e) {
      return HttpErrorHandler.onHandshakeException(e);
    } on DioError catch (e) {
      return HttpErrorHandler.onDioError(e);
    } on TimeoutException catch (e) {
      return HttpErrorHandler.onTimeout(e);
    }
  }

  Future<ApiResponse> delete(
    String url, {
    dynamic params = const {},
    Map<String, String> headers = const {},
  }) async {
    if (headers == null) {
      headers = getDefaultHeader();
    }

    URLQueryParams queryParams = URLQueryParams();
    if (params != null) {
      params.forEach((key, value) {
        queryParams.append(key, value);
      });
    }

    var targetUrl =
        url + (queryParams.toString().isNotEmpty ? "?$queryParams" : "");

    try {
      var response = await Dio()
          .delete(
            targetUrl,
            options: Options(
              headers: headers,
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              },
            ),
          )
          .timeout(Duration(milliseconds: timeout));

      if (HttpErrorHandler.onFailedButHasData(response)) {
        return Future.value(ApiResponse(
          status: ApiStatus.failed,
          data: response.data,
        ));
      }

      return Future.value(HttpErrorHandler.onRequestSuccess(response));
    } on HandshakeException catch (e) {
      return HttpErrorHandler.onHandshakeException(e);
    } on DioError catch (e) {
      return HttpErrorHandler.onDioError(e);
    } on TimeoutException catch (e) {
      return HttpErrorHandler.onTimeout(e);
    }
  }
}

var https = HttpHelper();
