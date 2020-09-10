import 'package:pos_app/core.dart';
import 'package:flutter/material.dart';

class AccordionPanelWeb extends StatefulWidget {
  final String headerText;
  final List<Widget> children;
  final IconData icon;

  final Color backgroundColor;
  final bool expanded;

  AccordionPanelWeb({
    @required this.headerText,
    @required this.children,
    this.icon = FontAwesomeIcons.clock,
    this.backgroundColor = Colors.white,
    this.expanded = true,
  });

  @override
  _AccordionPanelWebState createState() => _AccordionPanelWebState();
}

class _AccordionPanelWebState extends State<AccordionPanelWeb>
    with TickerProviderStateMixin {
  bool expanded = true;
  double contentHeight;

  @override
  void initState() {
    super.initState();
    expanded = widget.expanded;
    if (expanded) {
      expanded = false;
      contentHeight = 0;
    } else {
      expanded = true;
      contentHeight = null;
    }
  }

  getHeader() {
    if (widget.children.isEmpty) {
      return InkWell(
        onTap: () {
          if (expanded) {
            setState(() {
              expanded = false;
              contentHeight = 0;
            });
          } else {
            setState(() {
              expanded = true;
              contentHeight = null;
            });
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6.0),
              topRight: Radius.circular(6.0),
              bottomLeft: Radius.circular(6.0),
              bottomRight: Radius.circular(6.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.headerText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ),
              if (widget.children.isNotEmpty)
                Icon(
                  expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.white,
                  size: 14.0,
                ),
            ],
          ),
        ),
      );
    }

    return InkWell(
      onTap: () {
        if (expanded) {
          setState(() {
            expanded = false;
            contentHeight = 0;
          });
        } else {
          setState(() {
            expanded = true;
            contentHeight = null;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.0),
            topRight: Radius.circular(6.0),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                widget.headerText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
            ),
            if (widget.children.isNotEmpty)
              Icon(
                expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Colors.white,
                size: 14.0,
              ),
          ],
        ),
      ),
    );
  }

  getBody() {
    return AnimatedSize(
      duration: Duration(milliseconds: 350),
      curve: Curves.elasticIn,
      vsync: this,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: contentHeight,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(6.0),
            bottomRight: Radius.circular(6.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.children,
        ),
      ),
    );
  }

  getContent() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(6.0),
          bottomRight: Radius.circular(6.0),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: getBody(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 10.0),
      child: Column(
        children: <Widget>[
          getHeader(),
          getContent(),
        ],
      ),
    );
  }
}
