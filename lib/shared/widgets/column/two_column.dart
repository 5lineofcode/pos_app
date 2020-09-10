import 'package:flutter/material.dart';

class TwoColumn extends StatelessWidget {
  const TwoColumn({
    Key key,
    @required this.firstChild,
    this.secondChild,
  }) : super(key: key);

  final Widget firstChild;
  final Widget secondChild;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: firstChild,
        ),
        SizedBox(width: 15),
        Expanded(
          child: secondChild ?? Container(),
        ),
      ],
    );
  }
}
