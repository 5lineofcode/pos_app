import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class ExIconButton extends StatelessWidget {
  final IconData icon;
  final dynamic onPressed;

  final Color type;
  ExIconButton({
    @required this.onPressed,
    @required this.type,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      child: FlatButton.icon(
        color: type != null ? type : Colors.blue[900],
        icon: icon != null
            ? Container(
                padding: EdgeInsets.only(left: 10.0),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 14.0,
                ),
              )
            : Container(),
        label: Text(
          "",
          style: TextStyle(color: Colors.white, fontSize: 10.0),
          overflow: TextOverflow.visible,
        ),
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
        },
      ),
    );
  }
}
