import 'package:flutter/material.dart';

class ExPositioned extends StatelessWidget {
  final Widget child;
  final bool visibleIf;

  final double left;
  final double top;
  final double right;
  final double bottom;

  ExPositioned({
    @required this.child,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.visibleIf,
  });

  @override
  Widget build(BuildContext context) {
    if (visibleIf == false) return Container();

    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      width: 200.0,
      child: child,
    );
  }
}

class ExampelPage extends StatefulWidget {
  @override
  _ExampelPageState createState() => _ExampelPageState();
}

class _ExampelPageState extends State<ExampelPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[],
    );
  }
}
