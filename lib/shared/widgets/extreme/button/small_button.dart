import 'package:flutter/material.dart';

import 'package:pos_app/core.dart';

class ExSmallButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final dynamic onPressed;
  final double width;

  final Color type;
  ExSmallButton({
    @required this.label,
    @required this.onPressed,
    @required this.type,
    this.icon,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 24.0,
      child: FlatButton.icon(
        color: type != null ? type : Colors.blue[900],
        icon: icon != null
            ? Icon(
                icon,
                color: Colors.white,
                size: 12.0,
              )
            : Container(),
        label: Text(
          label != null ? trans(label) : "",
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
