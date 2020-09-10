import 'package:pos_app/core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vibration/vibration.dart';

class HandleMessaging {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static initFlutterLocalNotification() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  static Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {}

  static bool showAlert = true;
  static String progressStatus;
  static Future showNotificationExample(String title, String message) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      message,
      platformChannelSpecifics,
      payload: 'item id 2',
    );
  }

  static Future onSelectNotification(String payload) async {
    if (payload != null) {}
  }

  static Future requestPermissionAndInit() async {
    if (Platform.isAndroid) {
      await firebaseMessaging.requestNotificationPermissions();
    } else if (Platform.isIOS) {
      await getApplePermission();
    }
    await HandleMessaging.initEvent();
    await HandleMessaging.initFlutterLocalNotification();
  }

  static getApplePermission() async {
    await firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      debugPrint("Settings registered on iOS: $settings");
    });
  }

  static Future initEvent() async {
    await firebaseMessaging.subscribeToTopic("topic");
    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> message) {
        return;
      },
      onMessage: (Map<String, dynamic> message) async {
        var title = message["notification"]["title"];
        var body = message["notification"]["body"];

        await HandleMessaging.showNotificationExample(title, body);

        bool hasVibrator = await Vibration.hasVibrator();
        if (hasVibrator) {
          await Vibration.vibrate(
            duration: 1000,
          );
        }
      },
      onResume: (Map<String, dynamic> message) {
        return;
      },
    );
  }

  static Future getToken() async {
    return await firebaseMessaging.getToken();
  }
}
