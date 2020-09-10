import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class ExCircleButton extends StatelessWidget {
  const ExCircleButton({
    @required this.icon,
    @required this.onPressed,
    this.elevation = 0.1,
    this.sizeButton = 40,
    this.sizeIcon = 14,
    this.color = Colors.blue,
    this.iconColor = Colors.white,
    Key key,
  }) : super(key: key);

  final double sizeButton, sizeIcon, elevation;
  final IconData icon;
  final Color color, iconColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeButton,
      width: sizeButton,
      child: RaisedButton(
        onPressed: onPressed,
        elevation: elevation,
        padding: EdgeInsets.all(0),
        shape: CircleBorder(),
        color: color,
        child: Icon(
          icon,
          size: sizeIcon,
          color: iconColor,
        ),
      ),
    );
  }
}
