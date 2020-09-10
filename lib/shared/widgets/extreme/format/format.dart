import 'package:pos_app/core.dart';

class Format {
  static final numFormat = NumberFormat("#.##");

  static parseInt(value) {
    var newValue = int.tryParse(value.toString());
    if (newValue == null) {
      return 0;
    }
    return newValue;
  }

  static getDate(dynamic date, {String format = "d MMM, y"}) {
    try {
      DateTime dateTime = DateTime.parse(date.toString());
      return DateFormat(format).format(dateTime);
    } on Exception catch (_) {
      return date.toString();
    }
  }

  static getDateTime(dynamic date, {String format = "dd MMM yyyy kk:ss"}) {
    try {
      DateTime dateTime = DateTime.parse(date.toString());
      return DateFormat(format).format(dateTime);
    } on Exception catch (_) {
      return date.toString();
    }
  }

  static getTimeFormat(str) {
    if (str.toString().isEmpty || str.toString().length < 2) {
      return "--:--";
    }

    try {
      var hh = str.substring(0, 2);
      var mm = str.substring(2, 4);
      return "$hh:$mm";
    } on Exception catch (_) {
      return "--:--";
    }
  }

  static number(dynamic value) {
    if (value == null) {
      return "0";
    }

    if (value is num) {
      return numFormat.format(value);
    } else {
      var parsResult = num.tryParse(value);
      if (parsResult != null) {
        return numFormat.format(parsResult);
      }
    }
    return value;
  }
}
