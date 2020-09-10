import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class MessageToast extends StatelessWidget {
  const MessageToast(
      {@required this.text,
      @required this.alertType,
      @required this.onClose,
      Key key})
      : super(key: key);
  final AlertType alertType;
  final String text;
  final Function() onClose;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: alertType == AlertType.success
          ? Helper.hexToColor("#33D0AE")
          : Helper.hexToColor("#F45938"),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                alertType == AlertType.success ? Icons.check : Icons.close,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text ?? "",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            
            
            
            
            
            
            
            
          ],
        ),
      ),
    );
  }
}
