import 'package:flutter/material.dart';

import 'package:pos_app/core.dart';

class LinkedLabelRadio extends StatelessWidget {
  const LinkedLabelRadio({
    this.label,
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Stack(
        children: <Widget>[
          Radio<bool>(
            activeColor: ButtonType.warning,
            groupValue: groupValue,
            value: value,
            onChanged: onChanged,
          ),
          Positioned(
            top: 10.0,
            left: 38,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 3.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: TS.config["text_font_size"],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
