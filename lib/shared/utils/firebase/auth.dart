import 'package:firebase_auth/firebase_auth.dart';
import 'package:pos_app/core.dart';

import 'handle_messaging.dart';

class FirebaseAuthVM {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseUser firebaseUser;

  static Future firebaseSignInAndGetFcmToken() async {
    await HandleMessaging.requestPermissionAndInit();

    var fcmToken = await HandleMessaging.getToken();
    AppSession.fcmToken = fcmToken;
  }

  static Future<void> handleSignOut() async {
    await firebaseAuth.signOut();
    firebaseUser = null;
  }
}
