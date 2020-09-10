import 'package:flutter/material.dart';

class LineHeader extends StatelessWidget {
  const LineHeader({
    Key key,
    @required this.label,
    this.labelSize = 17,
    this.padding,
    this.contentPadding,
    this.actions,
  }) : super(key: key);
  final String label;
  final double labelSize;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry contentPadding;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.only(bottom: 8),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: contentPadding ?? EdgeInsets.only(left: 3, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    fontSize: labelSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (actions != null) ...actions.map((e) => e).toList(),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Divider(
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
