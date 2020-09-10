import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_app/core.dart';
import 'package:intl/intl.dart';

class Helper {
  static bool isOffline = true;

  
  

  
  

  
  

  
  

  

  

  

  
  

  
  

  
  
  
  
  

  
  
  
  
  
  
  
  

  static Future push(BuildContext context, Widget page) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => page));
  }

  static Future pushReplacement(BuildContext context, Widget page) {
    return Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => page));
  }

  static Future pushNamed(BuildContext context, String routeName) {
    return Navigator.of(context).pushNamed(routeName);
  }

  static Future pushReplacementNamed(BuildContext context, String routeName) {
    return Navigator.of(context).pushReplacementNamed(routeName);
  }

  static void copyText(String text) {
    Clipboard.setData(new ClipboardData(text: text));
    BotToast.showCustomNotification(
      animationDuration: Duration(milliseconds: 500),
      animationReverseDuration: Duration(milliseconds: 500),
      duration: Duration(seconds: 3),
      toastBuilder: (cancel) {
        return MessageToast(
          text: "Copied to Clipboard",
          alertType: AlertType.success,
          onClose: cancel,
        );
      },
    );
  }

  static Color hexToColor(String code) {
    return code == null
        ? Colors.black54
        : Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}'.toUpperCase();
  }

  static String numberFormat(int number) {
    final formatter = new NumberFormat("#,###");
    return formatter.format(number);
  }

  static String stringFormatYmd(String date) {
    if (date == null)
      return null;
    else {
      var data = date.split("-");

      if (data.length < 3) data = date.split("/");
      if (data.length < 3) return null;

      var day = data[0];
      var month = data[1];
      var year = data[2];
      return "$year-$month-$day";
    }
  }

  static DateTime dateFormatYmd(String date) {
    if (date == null)
      return null;
    else {
      var data = date.split("-");

      if (data.length < 3) data = date.split("/");
      if (data.length < 3) return null;

      var day = data[0];
      var month = data[1];
      var year = data[2];
      return DateTime.parse("$year-$month-$day");
    }
  }

  static String stringFormatDmy(DateTime date) {
    return date == null ? null : DateFormat("dd-MM-yyyy, hh:mm a").format(date);
  }

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
