import 'package:flutter/material.dart';

class ExCardTile extends StatelessWidget {
  const ExCardTile({
    Key key,
    this.child,
    this.elevation = 7,
    this.shadowColor,
    this.color,
    this.borderRadius,
  }) : super(key: key);

  final Widget child;
  final double elevation;
  final Color shadowColor;
  final Color color;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      shadowColor: shadowColor ?? Colors.grey[400],
      borderRadius: borderRadius ?? BorderRadius.circular(4),
      color: color ?? Colors.white,
      child: child,
    );
  }
}
