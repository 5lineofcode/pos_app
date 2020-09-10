import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class EditButton extends StatefulWidget {
  final Function onPressed;

  EditButton({
    @required this.onPressed,
  });
  @override
  _EditButtonState createState() => _EditButtonState();
}

class _EditButtonState extends State<EditButton> {
  @override
  Widget build(BuildContext context) {
    return ExButton(
      label: "Edit",
      type: ButtonType.warning,
      icon: Icons.edit,
      onPressed: () => widget.onPressed(),
    );
  }
}
