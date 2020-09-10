import 'package:device_info/device_info.dart';

class AppSession {
  static AndroidDeviceInfo androidDeviceInfo;
  static IosDeviceInfo iosDeviceInfo;

  static String baseUrl = "";
  static String hostUrl = "";

  static String accessToken = "";
  static String fcmToken = "";
}

asset(url) {
  return "${AppSession.baseUrl}$url";
}
