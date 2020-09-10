import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:get/get.dart';
import 'package:pos_app/core.dart';
import 'package:flutter/material.dart';

import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'shared/utils/getrouter/getrouter.dart';

class MobileApp extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<MobileApp> {
  static AppState instance;
  bool loading = true;
  int randomNumber = 0;
  refresh() {
    this.setState(() {
      randomNumber = Random().nextInt(9999999);
    });
  }

  initData() async {
    await AppSessionTheme.saveDefaultTheme();
    await AppSessionTheme.loadTheme();

    setState(() {
      loading = false;
    });
  }

  initAlert() {
    ExAlert.successImage = "assets/images/success_alert.jpg";
    ExAlert.errorImage = "assets/images/reject_alert.jpg";
    ExAlert.confirmationImage = "assets/images/confirm_alert.png";

    ExAlert.warningImage = "assets/images/success_alert.jpg";
    ExAlert.infoImage = "assets/images/success_alert.jpg";

    ExAlert.approveImage = "assets/images/confirm_alert.png";
    ExAlert.rejectImage = "assets/images/reject_alert.jpg";
  }

  @override
  void initState() {
    super.initState();
    AppState.instance = this;
    initData();
    initAlert();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      data: (brightness) => AppSessionTheme.getCurrentTheme(),
      themedWidgetBuilder: (context, theme) {
        return OverlaySupport(
          child: GetMaterialApp(
            title: "FlutterApp",
            initialRoute: '/',
            debugShowCheckedModeBanner: false,
            navigatorKey: navHelper.navigatorKey,
            onGenerateRoute: getRouter,
            theme: theme,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('id', 'ID'),
            ],
          ),
        );
      },
    );
  }
}
