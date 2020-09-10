import 'package:shared_preferences/shared_preferences.dart';
import 'package:pos_app/core.dart';

class LocalStorage {
  static Future clearLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static save(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("$key", value.toString());
  }

  static Future savePermanent(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("permanent_$key", value.toString());
  }

  static Future deletePermanent(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("permanent_$key");
  }

  static Future saveJson(key, value) async {
    value = jsonEncode(value);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("$key", value.toString());
  }

  static load(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString("$key");
    } on Exception catch (_) {
      debugPrint('\x1B[94m hahAHaHA!!! \x1B[0m');
    }
  }

  static Future loadPermanent(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString("permanent_$key");
    } on Exception catch (_) {
      debugPrint('\x1B[94m hahAHaHA!!! \x1B[0m');
    }
  }

  static Future<Map<String, dynamic>> loadMap(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonString = prefs.getString(key);

    if (jsonString == null) return {};

    Map map = json.decode(jsonString);
    return map ?? {};
  }

  static Future<bool> loadBoolean(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) == "true" ? true : false;
  }

  static Future<List<dynamic>> loadList(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var jsonString = prefs.getString(key);

      if (jsonString == null) return [];

      var list = json.decode(jsonString);
      if (list is List<dynamic>) {
        return list;
      }
      return [];
    } on Exception catch (_) {
      debugPrint("localStorage loadList error");
      print(_);
      return [];
    }
  }
}
