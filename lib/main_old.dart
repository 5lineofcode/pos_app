import 'package:pos_app/core.dart';
import 'package:pos_app/main_mobile.dart';
import 'package:flutter/material.dart';

void main() async {
  AppSession.hostUrl = "http://209.97.167.43:3024/";
  //AppSession.hostUrl = "http://localhost:3024/";

  WidgetsFlutterBinding.ensureInitialized();

  AppSession.baseUrl = "${AppSession.hostUrl}api/app/";

  Intl.defaultLocale = 'en_US';

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
    ),
  );

  await ApplicationOrientation.setPotrait();
  runApp(MobileApp());
}
