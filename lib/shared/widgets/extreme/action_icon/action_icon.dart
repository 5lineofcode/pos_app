import 'package:pos_app/core.dart';
import 'package:flutter/material.dart';

class ActionIcon extends StatefulWidget {
  final dynamic onTap;
  final int notifyCount;
  final IconData icon;
  final Color color;
  final double size;

  ActionIcon({
    @required this.icon,
    @required this.onTap,
    this.notifyCount = 0,
    this.color = Colors.white,
    this.size,
  });

  @override
  _ActionIconState createState() => _ActionIconState();
}

class _ActionIconState extends State<ActionIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.only(
          right: 16.0,
        ),
        child: Center(
          child: Badge(
            showBadge: widget.notifyCount > 0,
            badgeContent: Text(
              widget.notifyCount.toString(),
              style: TextStyle(color: Colors.white),
            ),
            badgeColor: ButtonType.danger,
            child: Icon(
              widget.icon,
              size: widget.size ?? 30.0,
              color: widget.color,
            ),
          ),
        ),
      ),
    );
  }
}
