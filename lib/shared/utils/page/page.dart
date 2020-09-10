import 'package:flutter/material.dart';

class Page {
  static String lastRouteName = "/home";
  static Future show(BuildContext context, newPage) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => newPage,
      ),
    );

    return Future.value(true);
  }

  static replace(BuildContext context, newPage) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => newPage,
      ),
    );
  }

  static clearAndPush(BuildContext context, newPage) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => newPage,
        ),
        (route) => false);
  }

  static popUntilHome(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  static popUntilRouteName(BuildContext context, String routeName) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }
}
