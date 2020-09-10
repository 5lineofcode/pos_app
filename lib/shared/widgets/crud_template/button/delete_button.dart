import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class DeleteButton extends StatefulWidget {
  final Function onPressed;

  DeleteButton({
    @required this.onPressed,
  });
  @override
  _DeleteButtonState createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  @override
  Widget build(BuildContext context) {
    return ExButton(
      label: "Delete",
      type: ButtonType.danger,
      icon: Icons.edit,
      onPressed: () => widget.onPressed(),
    );
  }
}
