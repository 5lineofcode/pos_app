import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class RadioGroup extends StatefulWidget {
  final List<Widget> children;
  RadioGroup({
    this.children,
  });

  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      elevation: TS.getCardElevation(),
      child: Container(
        height: 40.0,
        child: Row(
          children: widget.children,
        ),
      ),
    );
  }
}
