import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pos_app/core.dart';

class HttpErrorHandler {
  static onHandshakeException(HandshakeException e) {}
  static onDioError(DioError e) {
    debugPrint("###############################");
    debugPrint("HTTP Request Dio Error");
    debugPrint("###############################");
    debugPrint("Url: ${e.response?.request?.uri}");
    debugPrint("StatusCode: ${e.response?.statusCode}");
    debugPrint("Data:\n--\n${e.response?.data}\n--\n");
    debugPrint("Data:\n--\n${e.message}\n--\n");

    if (e.response != null) {
      if (e.response.data != null) {
        debugPrint("This Response has Data");
      }
    } else {
      debugPrint("This Response is Null");
    }

    debugPrint("###############################");
    debugPrint(e.type.toString());
    debugPrint("###############################");

    switch (e.type) {
      case DioErrorType.DEFAULT:
        return Future.value(ApiResponse(
          status: ApiStatus.error,
        ));
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        return Future.value(ApiResponse(
          status: ApiStatus.timeout,
        ));
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        return Future.value(ApiResponse(
          status: ApiStatus.timeout,
        ));
        break;
      case DioErrorType.SEND_TIMEOUT:
        return Future.value(ApiResponse(
          status: ApiStatus.timeout,
        ));
        break;
      case DioErrorType.CANCEL:
        return Future.value(ApiResponse(
          status: ApiStatus.error,
        ));
        break;
      case DioErrorType.RESPONSE:
        return Future.value(ApiResponse(
          status: ApiStatus.failed,
        ));
        break;
    }
  }

  static onTimeout(TimeoutException e) {
    debugPrint("###############################");
    debugPrint("HTTP Request TimeoutException");
    debugPrint("###############################");
    debugPrint("TIMEOUT");

    return Future.value(ApiResponse(
      status: ApiStatus.timeout,
    ));
  }

  static bool onFailedButHasData(Response response) {
    
    
    
    
    
    

    if (!response.statusCode.toString().startsWith("2") &&
        response.data != null) {
      return true;
    }
    return false;
  }

  static ApiResponse onRequestSuccess(Response response) {
    
    
    
    
    
    

    return ApiResponse(
      status: ApiStatus.success,
      data: response.data,
    );
  }
}
