import 'package:flutter/material.dart';

class TabText extends StatefulWidget {
  final String label;

  TabText({
    this.label,
  });

  @override
  _TabTextState createState() => _TabTextState();
}

class _TabTextState extends State<TabText> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Text(widget.label),
    );
  }
}
