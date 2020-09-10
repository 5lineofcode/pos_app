import 'package:flutter/material.dart';

class HeaderText extends StatefulWidget {
  final String text;
  HeaderText({
    @required this.text,
  });

  @override
  _HeaderTextState createState() => _HeaderTextState();
}

class _HeaderTextState extends State<HeaderText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
