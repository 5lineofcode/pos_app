import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class ExRow extends StatefulWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final SpaceStyle spaceStyle;
  final double spaceSize;

  ExRow({
    @required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.spaceStyle = SpaceStyle.spaceBetween,
    this.spaceSize = 10.0,
  });

  @override
  _ExRowState createState() => _ExRowState();
}

class _ExRowState extends State<ExRow> {
  List<Widget> children = [];

  initChildren() {
    children = widget.children;
    formatChildren();
  }

  spaceBetweenStyle() {
    for (var i = 1; i < children.length; i++) {
      children[i] = Container(
        margin: EdgeInsets.only(left: widget.spaceSize),
        child: children[i],
      );
    }
  }

  expandedStyle() {
    for (var i = 0; i < children.length; i++) {
      children[i] = Expanded(
        child: Container(
          margin: EdgeInsets.only(left: i == 0 ? 0 : widget.spaceSize),
          child: children[i],
        ),
      );
    }
  }

  formatChildren() {
    if (widget.spaceStyle == SpaceStyle.spaceBetween) {
      spaceBetweenStyle();
    } else if (widget.spaceStyle == SpaceStyle.expandedSpaceBetween) {
      expandedStyle();
    }
  }

  @override
  void initState() {
    super.initState();
    initChildren();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: children,
    );
  }
}
