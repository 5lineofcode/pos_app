import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class AddButton extends StatefulWidget {
  final Function onPressed;

  AddButton({
    @required this.onPressed,
  });
  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return ExButton(
      label: "Add",
      type: ButtonType.success,
      icon: Icons.add_box,
      onPressed: () => widget.onPressed(),
    );
  }
}
