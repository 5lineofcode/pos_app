import 'package:flutter/material.dart';

import 'package:pos_app/core.dart';

class ExRangeSlider extends StatefulWidget {
  final String id;
  final String label;
  final double min;
  final double max;
  final double value;

  final dynamic onChanged;
  ExRangeSlider({
    @required this.id,
    this.label = "",
    this.min = 6.0,
    this.max = 40.0,
    this.value = 6.0,
    this.onChanged,
  });

  @override
  _ExRangeSliderState createState() => _ExRangeSliderState();
}

class _ExRangeSliderState extends State<ExRangeSlider> {
  double selectedValue = 6.0;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value ?? widget.min;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 20.0,
              ),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: TS.config["text_font_size"],
                  color: TS.config["text_color"],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                selectedValue.round().toString(),
                style: TextStyle(
                  fontSize: TS.config["text_font_size"],
                  color: TS.config["text_color"],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: 20.0,
              ),
            ],
          ),
          Slider(
            value: selectedValue,
            min: widget.min,
            max: widget.max,
            onChanged: (value) {
              setState(() {
                selectedValue = value;
                Input.set(widget.id, value);
              });
              if (widget.onChanged != null) {
                widget.onChanged(selectedValue);
              }
            },
          ),
        ],
      ),
    );
  }
}
