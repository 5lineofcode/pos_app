import 'package:pos_app/core.dart';
import 'package:flutter/material.dart';

class ErrorHandler {
  static handle(ApiResponse apiResponse, BuildContext context) {
    AppLoading.hide(context);

    if (apiResponse.status == ApiStatus.failed) {
      if (apiResponse?.data != null) {
        ExAlert.showError(
          context: context,
          message: apiResponse?.data["errors"][0]["code"],
        );
        return;
      }

      ExAlert.showError(
        context: context,
        message: "Request Failed, Connection Problem",
      );

      return;
    }

    if (apiResponse.status == ApiStatus.timeout) {
      ExAlert.showError(
        context: context,
        message: "Request Timeout, Please check your Internet Connection",
      );
      return;
    } else if (apiResponse.status == ApiStatus.socketError) {
      /*
      Saat ini, SocketError belum berhasil tertangkap,
      Oleh itu SocketError akan di anggap sebagai undefined
      */

      ExAlert.showError(
        context: context,
        message: apiResponse.message,
      );

      return;
    } else {
      ExAlert.showError(
        context: context,
        message: "Undefined Error",
      );
      return;
    }
  }
}
