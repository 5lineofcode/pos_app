import 'package:pos_app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerButton extends StatefulWidget {
  final String themeKey;
  final String text;
  final dynamic onChanged;

  ColorPickerButton({
    @required this.themeKey,
    @required this.text,
    this.onChanged,
  });

  @override
  _ColorPickerButtonState createState() => _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  showColorPicker() async {
    await showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: TS.config[widget.themeKey],
            onColorChanged: (newColor) {
              TS.config[widget.themeKey] = newColor;
              setState(() {});
            },
            enableLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );

    if (widget.onChanged != null) {
      widget.onChanged();
    }
    AppSessionTheme.updateCurrentTheme(context);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: ExButton(
              label: widget.text,
              type: TS.config[widget.themeKey],
              onPressed: showColorPicker,
            ),
          ),
          Container(
            height: 8.0,
          ),
          Text(
            widget.text,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
