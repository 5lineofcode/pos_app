import 'package:flutter/material.dart';

class ExCheckbox extends StatefulWidget {
  final bool value;
  final String label;
  final dynamic onChanged;
  final EdgeInsetsGeometry padding;

  ExCheckbox({
    @required this.value,
    @required this.label,
    @required this.onChanged,
    this.padding = const EdgeInsets.all(0.0),
  });

  @override
  _ExCheckboxState createState() => _ExCheckboxState();
}

class _ExCheckboxState extends State<ExCheckbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var newValue = widget.value ? false : true;
        widget.onChanged(newValue);
      },
      child: Container(
        padding: widget.padding,
        child: Row(
          children: <Widget>[
            Icon(
              widget.value ? Icons.check_box : Icons.check_box_outline_blank,
              color: Theme.of(context).primaryColor,
            ),
            Text(widget.label),
          ],
        ),
      ),
    );
  }
}
