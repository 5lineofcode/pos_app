import 'package:pos_app/core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class Notification {
  showNotification() {
    showSimpleNotification(
      Row(
        children: <Widget>[
          Icon(
            FontAwesomeIcons.infoCircle,
            color: Colors.white,
            size: 30.0,
          ),
          Container(
            width: 10.0,
          ),
          Expanded(
            child: Text(
              "this is a message from simple notification",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      trailing: Builder(builder: (context) {
        return FlatButton(
          textColor: Colors.yellow,
          onPressed: () {
            OverlaySupportEntry.of(context).dismiss();
          },
          child: Text(
            'Dismiss',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        );
      }),
      background: Colors.red[600],
      autoDismiss: false,
      slideDismiss: true,
    );
  }
}
