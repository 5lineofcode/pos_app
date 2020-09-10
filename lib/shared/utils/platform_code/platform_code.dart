import 'dart:async';
import 'package:flutter/services.dart';

class PlatformCode {
  static const platform = MethodChannel('flutter.native/helper');
  static Future callHelloFromNativeCode() async {
    String message;
    try {
      var result = await platform.invokeMethod('helloFromNativeCode');
      message = result;
    } on PlatformException catch (e) {
      message = "Failed to get Message from Native";
      print(e.message);
    }

    print("Result:\n$message");
    return message;
  }
}
