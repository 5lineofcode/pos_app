import 'package:flutter/material.dart';

class TabIcon extends StatefulWidget {
  final IconData icon;
  final String label;

  TabIcon({
    this.icon,
    this.label,
  });

  @override
  _TabIconState createState() => _TabIconState();
}

class _TabIconState extends State<TabIcon> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(widget.icon),
          Container(
            height: 4.0,
          ),
          Expanded(
            child: Text(
              widget.label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
