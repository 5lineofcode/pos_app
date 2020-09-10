import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ApplicationOrientation {
  static setPotrait() async {
    if (kIsWeb) return;

    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  static setLandscape() async {
    if (kIsWeb) return;

    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft]);
  }
}
