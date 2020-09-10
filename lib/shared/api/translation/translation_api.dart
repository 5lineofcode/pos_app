import 'package:pos_app/core.dart';

class TranslationApi {
  static String language = "id";
  static String userName = "new_user";
  final Map<String, Map<String, dynamic>> _translation = {};
  String _baseUrl = "";

  TranslationApi._internal();

  static final TranslationApi _singleton = TranslationApi._internal();

  factory TranslationApi() {
    return _singleton;
  }

  enableTranslation({
    String baseUrl,
  }) {
    _baseUrl = baseUrl;
  }

  Future<void> getTranslationInformation() async {
    int serverVersionNumber = await _checkServerVersionNumber();
    int deviceVersionNumber = await _checkDeviceVersionNumber();

    debugPrint("ServerTransVersion: $serverVersionNumber");
    debugPrint("DeviceTransVersion: $deviceVersionNumber");

    if (serverVersionNumber != deviceVersionNumber) {
      await _loadTranslationFromCloud(serverVersionNumber);
    } else {
      await _loadTranslationFromLocalStorage(serverVersionNumber);
    }
  }

  String getTranslation(String text) {
    if (_baseUrl == "") {
      return text;
    }

    Map<String, dynamic> trans = _translation[text];
    if (trans != null) {
      return trans[_getLanguageByCode()];
    } else {
      _registerUndefinedWord(text);
      return text;
    }
  }

  Map<String, String> _getHeader() {
    return {
      "X-Auth-Token": "",
    };
  }

  Future<int> _checkServerVersionNumber() async {
    var url = "${_baseUrl}gaji-id-att-api/custom/translation/version";
    var response = await http.get(
      url,
      headers: _getHeader(),
    );

    if (response.toString().contains("Site Maintenance")) {
      debugPrint("#####################");
      debugPrint("#####################");
      debugPrint("WEBSITE MAINTENANCE");
      debugPrint("#####################");
      debugPrint("#####################");
      return 0;
    }
    return Future.value(response["data"]["version"]);
  }

  Future<int> _checkDeviceVersionNumber() async {
    var version = await LocalStorage.loadPermanent("version_number");
    if (version != null) {
      return Future.value(int.parse(version.toString()));
    }
    return Future.value(0);
  }

  Future<void> _loadTranslationFromLocalStorage(int versionNumber) async {
    var localTranslation = await LocalStorage.loadPermanent("translation");
    if (localTranslation != "") {
      List localListTranslation = jsonDecode(localTranslation);
      _putTranslationToLocalCache(localListTranslation);
    } else {
      await _loadTranslationFromCloud(versionNumber);
    }
  }

  Future<void> _loadTranslationFromCloud(int versionNumber) async {
    var url = "${_baseUrl}gaji-id-att-api/custom/translation/all";
    var response = await http.get(
      url,
      headers: _getHeader(),
    );
    List localListTranslation = response["data"]["translations"];
    _putTranslationToLocalCache(localListTranslation);

    await LocalStorage.savePermanent(
        "translation", jsonEncode(localListTranslation));
    await LocalStorage.savePermanent("version_number", versionNumber);
  }

  void _putTranslationToLocalCache(List localListTranslation) {
    _translation.clear();
    localListTranslation.forEach((trans) {
      _translation[trans["stringCode"].toString()] = trans;
    });
  }

  String _getLanguageByCode() {
    String code = TranslationApi.language;
    switch (code) {
      case "id":
        return "indonesia";
        break;
      case "en":
        return "english";
        break;
      case "de":
        return "german";
        break;
      default:
        return "indonesia";
    }
  }

  Future<String> _registerUndefinedWord(String word) async {
    if (!kReleaseMode) {
      return word;
    }

    try {
      if (_baseUrl == "") {
        return word;
      }
      var url = "${_baseUrl}gaji-id-att-api/custom/translation/single";
      var response = await http.get(
        url,
        params: {
          "stringCode": word,
        },
        headers: _getHeader(),
      );

      if (response != null &&
          response["data"] != null &&
          response["data"]["translation"] != null) {
        Map<String, dynamic> trans = response["data"]["translation"];
        _translation[trans["stringCode"].toString()] = trans;
        return trans[_getLanguageByCode()];
      } else {
        return word;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      debugPrint("TranslationApi: registerUNdefinedWord error");
      return word;
    }
  }
}

String trans(String text) {
  if (text == null || text.trim().isEmpty) {
    return text;
  }
  return TranslationApi().getTranslation(text);
}
