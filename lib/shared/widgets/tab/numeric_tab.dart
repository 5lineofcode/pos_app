import 'package:pos_app/core.dart';
import 'package:flutter/material.dart';

class NumericTab extends StatefulWidget {
  final String title;
  final int itemCount;
  final Color color;

  NumericTab({
    @required this.title,
    @required this.itemCount,
    @required this.color,
  });
  @override
  _NumericTabState createState() => _NumericTabState();
}

class _NumericTabState extends State<NumericTab> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(trans(widget.title)),
          Container(
            width: 5.0,
          ),
          if (widget.itemCount > 0)
            CircleAvatar(
              backgroundColor: widget.color,
              radius: 15.0,
              child: Text(
                widget.itemCount.toString(),
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
