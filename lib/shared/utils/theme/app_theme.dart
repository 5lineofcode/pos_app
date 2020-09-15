import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:pos_app/core.dart';
import 'package:flutter/material.dart';

class ThemeTemplate {
  static String defaultTheme = "default_theme";
  static String blueTheme = "blue_theme";
  static String orangeTheme = "orang_theme";
  static String purpleTheme = "purple_theme";
  static String customTheme = "custom_theme";
}

class TS {
  static Map<String, dynamic> config = {
    // "font_family": "Samsung",
    "font_family": "GothamRounded",
    "current_theme": "default_theme",
    "background_color": Color(0xffe8e9ec),
    "radio_background_color": Color(0xffe4e7f0),
    "primary_color": Color.fromRGBO(13, 124, 56, 1),
    "header_text_color": Color(0xff393a3f),
    "sub_header_text_color": Colors.white,
    "text_color": Colors.grey[600],
    "value_color": Colors.grey[800],
    "text_font_size": 12.0,
    "value_font_size": 12.0,
    "menu_font_size": 14.0,
    "success_button_color": Color.fromRGBO(13, 124, 56, 1),
    "danger_button_color": Color(0xffd9534f),
    "warning_button_color": Color(0xfffd6600),
    "info_button_color": Color(0xff5bc0de),
    "primary_button_color": Color(0xff337ab7),
    "button_text_color": Colors.white,
    "card_elevation": 4.0,
    "tab_indicator_color": Colors.white,
  };

  static getHeaderTextColor() => config["header_text_color"];

  static getBackground() => config["background_color"];

  static getTextColor() => config["text_color"];

  static getValueColor() => config["value_color"];

  static getRadioBackground() => config["radio_background_color"];

  static getPrimaryColor() => config["primary_color"];

  static getCardElevation() => config["card_elevation"];

  static getTabIndicatorColor() {
    return config["tab_indicator_color"];
  }

  static BoxDecoration getBoxDecoration({
    Color color = Colors.white,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey[400],
          blurRadius: 4.0,
        ),
      ],
    );
  }
}

class AppSessionTheme {
  static TextTheme getTextTheme() {
    return TextTheme(
      bodyText1: TextStyle(
        fontSize: TS.config["text_font_size"],
        color: TS.config["text_color"],
        fontFamily: TS.config["font_family"],
      ),
      bodyText2: TextStyle(
        fontSize: TS.config["value_font_size"],
        color: TS.config["value_color"],
        fontFamily: TS.config["font_family"],
      ),
    );
  }

  static ThemeData getOldDefaultTheme() {
    TS.config["font_family"] = "Samsung";
    TS.config["current_theme"] = ThemeTemplate.defaultTheme;
    TS.config["primary_color"] = Color.fromRGBO(13, 124, 56, 1);

    var themeData = ThemeData(
      backgroundColor: TS.config["background_color"],
      primarySwatch: getMaterialColor(TS.getPrimaryColor()),
      primaryTextTheme: TextTheme(
        headline6: TextStyle(
          color: TS.config["header_text_color"],
        ),
      ),
      primaryIconTheme: const IconThemeData.fallback().copyWith(
        color: TS.config["header_text_color"],
      ),
      accentIconTheme: const IconThemeData.fallback().copyWith(
        color: TS.config["header_text_color"],
      ),
      fontFamily: TS.config["font_family"],
      textTheme: getTextTheme(),
    );

    saveTheme();
    return themeData;
  }

  static ThemeData getDefaultTheme() {
    TS.config["font_family"] = "GothamRounded";
    TS.config["current_theme"] = ThemeTemplate.defaultTheme;
    TS.config["primary_color"] = Colors.white;

    var themeData = ThemeData(
      backgroundColor: TS.config["background_color"],
      primarySwatch: getMaterialColor(TS.getPrimaryColor()),
      primaryTextTheme: TextTheme(
        headline6: TextStyle(
          color: TS.config["header_text_color"],
        ),
      ),
      primaryIconTheme: const IconThemeData.fallback().copyWith(
        color: TS.config["header_text_color"],
      ),
      accentIconTheme: const IconThemeData.fallback().copyWith(
        color: TS.config["header_text_color"],
      ),
      fontFamily: TS.config["font_family"],
      textTheme: getTextTheme(),
    );

    saveTheme();
    return themeData;
  }

  static ThemeData getBlueTheme() {
    TS.config["current_theme"] = ThemeTemplate.blueTheme;
    TS.config["primary_color"] = Color(0xff043A76);

    var themeData = ThemeData(
      backgroundColor: TS.config["background_color"],
      primarySwatch: getMaterialColor(TS.getPrimaryColor()),
      primaryTextTheme: TextTheme(
        headline6: TextStyle(
          color: TS.config["header_text_color"],
        ),
      ),
      primaryIconTheme: const IconThemeData.fallback().copyWith(
        color: TS.config["header_text_color"],
      ),
      accentIconTheme: const IconThemeData.fallback().copyWith(
        color: TS.config["header_text_color"],
      ),
      fontFamily: TS.config["font_family"],
      textTheme: getTextTheme(),
    );

    saveTheme();
    return themeData;
  }

  static ThemeData getCustomTheme() {
    TS.config["current_theme"] = ThemeTemplate.customTheme;

    var themeData = ThemeData(
      backgroundColor: TS.config["background_color"],
      primarySwatch: getMaterialColor(TS.config["primary_color"]),
      primaryTextTheme: TextTheme(
        headline6: TextStyle(
          color: TS.config["header_text_color"],
        ),
      ),
      primaryIconTheme: const IconThemeData.fallback().copyWith(
        color: TS.config["header_text_color"],
      ),
      accentIconTheme: const IconThemeData.fallback().copyWith(
        color: TS.config["header_text_color"],
      ),
      fontFamily: TS.config["font_family"],
      textTheme: getTextTheme(),
    );

    saveTheme();
    return themeData;
  }

  static beforeSave() async {
    ButtonType.success = TS.config["success_button_color"];
    ButtonType.danger = TS.config["danger_button_color"];
    ButtonType.warning = TS.config["warning_button_color"];
    ButtonType.info = TS.config["info_button_color"];
    ButtonType.primary = TS.config["primary_button_color"];
    ButtonType.textColor = TS.config["button_text_color"];
  }

  static saveTheme() async {
    if (kIsWeb) {
      return;
    }

    await beforeSave();

    Map<String, dynamic> obj = {};

    TS.config.forEach((key, value) {
      if (value is Color) {
        Color color = value;
        int r = color.red;
        int g = color.green;
        int b = color.blue;

        obj[key] = "RGB $r|$g|$b";
      } else {
        obj[key] = value;
      }
    });

    await LocalStorage.savePermanent("theme_config", jsonEncode(obj));
  }

  static saveDefaultTheme() async {
    Map<String, dynamic> obj = {};

    TS.config.forEach((key, value) {
      if (value is Color) {
        Color color = value;
        int r = color.red;
        int g = color.green;
        int b = color.blue;

        obj[key] = "RGB $r|$g|$b";
      } else {
        obj[key] = value;
      }
    });

    await LocalStorage.savePermanent("default_theme_config", jsonEncode(obj));
  }

  static loadDefaultTheme() async {
    var jsonString = await LocalStorage.loadPermanent("default_theme_config");
    await LocalStorage.save("theme_config", jsonString);

    if (jsonString != "") {
      Map<String, dynamic> decoded = jsonDecode(jsonString);

      decoded.forEach((key, value) {
        if (value.toString().contains("RGB")) {
          var str = value.toString().replaceAll("RGB ", "");
          var arr = str.split("|");
          decoded[key] = Color.fromRGBO(
            int.parse(arr[0]),
            int.parse(arr[1]),
            int.parse(arr[2]),
            1,
          );
        }
      });

      TS.config = decoded;
    }
  }

  static loadTheme() async {
    try {
      var jsonString = await LocalStorage.loadPermanent("theme_config");

      if (jsonString != null) {
        Map<String, dynamic> decoded = jsonDecode(jsonString);

        decoded.forEach((key, value) {
          if (value.toString().contains("RGB")) {
            var str = value.toString().replaceAll("RGB ", "");
            var arr = str.split("|");
            decoded[key] = Color.fromRGBO(
              int.parse(arr[0]),
              int.parse(arr[1]),
              int.parse(arr[2]),
              1,
            );
          }
        });

        TS.config = decoded;
      }
    } on Exception catch (_) {}
  }

  static getCurrentTheme() {
    if (TS.config["current_theme"] == ThemeTemplate.defaultTheme) {
      return getDefaultTheme();
    }

    return getCustomTheme();
  }

  static updateCurrentTheme(context) {
    var selectedTheme;

    if (TS.config["current_theme"] == ThemeTemplate.defaultTheme) {
      selectedTheme = getDefaultTheme();
    } else {
      selectedTheme = getCustomTheme();
    }

    DynamicTheme.of(context).setThemeData(selectedTheme);
  }

  static applyTheme(context, themeData) {
    DynamicTheme.of(context).setThemeData(
      themeData,
    );
  }

  static dynamic boxShadow = [
    BoxShadow(
      color: Colors.grey[400],
      blurRadius: 1,
      spreadRadius: 0.5,
      offset: Offset(
        0.0,
        1.0,
      ),
    )
  ];

  static MaterialColor getMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: Colors.green.shade50,
      100: Colors.green.shade100,
      200: Colors.green.shade200,
      300: Colors.green.shade300,
      400: Colors.green.shade400,
      500: Colors.green.shade500,
      600: Colors.green.shade600,
      700: Colors.green.shade700,
      800: Colors.green.shade800,
      900: Colors.green.shade900
    });
  }

  static List<Color> getPrimaryGradientColor(BuildContext context) {
    int r = Theme.of(context).primaryColor.red;
    int g = Theme.of(context).primaryColor.green;
    int b = Theme.of(context).primaryColor.blue;

    return [
      Color.fromRGBO(r, g, b, 0.6),
      Color.fromRGBO(r, g, b, 0.9),
      Color.fromRGBO(r, g, b, 0.9),
      Color.fromRGBO(r, g, b, 1),
    ];
  }

  static getPrimaryGradient(context) {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [0.1, 0.5, 0.7, 0.9],
      colors: AppSessionTheme.getPrimaryGradientColor(context),
    );
  }

  static getPrimaryVerticalGradient(context) {
    return LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      stops: [
        0.1,
        0.5,
        0.7,
        0.9,
      ],
      colors: [
        Colors.green[900],
        Colors.green[900],
        Colors.green[900],
        Colors.green[900],
        // TS.getPrimaryColor(),
      ],
      // colors: AppSessionTheme.getPrimaryGradientColor(context),
    );
  }
}
