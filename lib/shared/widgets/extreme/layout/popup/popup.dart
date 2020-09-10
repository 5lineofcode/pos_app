import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExPopup {
  static BuildContext callerContext;

  static Future<void> show({
    BuildContext context,
    Widget content,
  }) async {
    ExPopup.callerContext = context;

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(
                    maxWidth: kIsWeb ? 400.0 : double.infinity,
                  ),
                  child: content,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
