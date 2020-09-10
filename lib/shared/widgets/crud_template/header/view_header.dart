import 'package:flutter/material.dart';

class ViewHeader extends StatefulWidget {
  final List<Widget> children;
  ViewHeader({
    @required this.children,
  });

  @override
  _ViewHeaderState createState() => _ViewHeaderState();
}

class _ViewHeaderState extends State<ViewHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(children: widget.children),
          Container(
            height: 1.0,
            margin: EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
            color: Colors.grey[200],
          ),
        ],
      ),
    );
  }
}
