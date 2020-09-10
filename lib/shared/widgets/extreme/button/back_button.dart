import 'package:flutter/material.dart';

class ExBackButton extends StatelessWidget {
  const ExBackButton({
    @required this.onPressed,
    Key key,
  }) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
        onPressed: onPressed,
        padding: EdgeInsets.all(7),
        icon: Icon(
          Icons.arrow_back_ios,
          size: 13,
          color: Colors.black87,
        ),
        label: Text("Go Back Home",
            style: TextStyle(
                fontSize: 13,
                color: Colors.black87,
                fontWeight: FontWeight.bold)));
  }
}
