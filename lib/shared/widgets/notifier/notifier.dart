import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';
import 'package:overlay_support/overlay_support.dart';

class Notifier {
  static show(String message) {
    showSimpleNotification(
      Text(
        trans(
          message,
        ),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      background: ButtonType.info,
      elevation: 0.2,
      leading: Icon(Icons.check),
    );
  }
}
