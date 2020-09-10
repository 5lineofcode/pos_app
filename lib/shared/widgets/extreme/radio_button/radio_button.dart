import 'package:pos_app/core.dart';
import 'package:flutter/material.dart';

class ExRadioButton extends StatelessWidget {
  final String id;
  final String label;
  final String initialValue;
  final double labelFontSize;
  final Axis mainAxis;
  final Color activeColor;
  final Color textColor;
  final List<String> values;

  ExRadioButton({
    @required this.id,
    @required this.label,
    this.labelFontSize,
    this.mainAxis = Axis.vertical,
    this.initialValue,
    this.values,
    this.activeColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    String _selected = initialValue;

    getLabel() {
      return Container(
        padding: EdgeInsets.only(
          left: 4.5,
          right: 4.0,
          top: 4.0,
          bottom: 4.0,
        ),
        width: MediaQuery.of(context).size.width,
        child: Text(
          trans(label),
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color,
            fontSize:
                labelFontSize ?? Theme.of(context).textTheme.bodyText1.fontSize,
            fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        getLabel(),
        Container(height: 3),
        StatefulBuilder(
          builder: (context, setState) {
            return Wrap(
              direction: mainAxis,
              children: values
                  .map((value) => InkWell(
                        onTap: () {
                          _selected = value;
                          Input.set(id, value);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 17.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                height: 35,
                                child: Radio(
                                  value: value,
                                  groupValue: _selected,
                                  onChanged: (String value) {
                                    setState(() {
                                      _selected = value;
                                      Input.set(id, value);
                                    });
                                  },
                                ),
                              ),
                              Text(
                                value,
                                style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .fontSize),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
