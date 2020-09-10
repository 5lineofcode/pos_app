import 'package:pos_app/core.dart';
import 'package:flutter/material.dart';

class AccordionPanel extends StatefulWidget {
  final String headerText;
  final List<Widget> children;
  final IconData icon;

  final Color backgroundColor;

  AccordionPanel({
    @required this.headerText,
    @required this.children,
    this.icon = FontAwesomeIcons.clock,
    this.backgroundColor = Colors.white,
  });

  @override
  _AccordionPanelState createState() => _AccordionPanelState();
}

class _AccordionPanelState extends State<AccordionPanel>
    with TickerProviderStateMixin {
  bool expanded = true;
  double contentHeight;

  getHeader() {
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
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.0),
            topRight: Radius.circular(6.0),
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              widget.icon,
              color: Colors.white,
            ),
            Container(
              width: 10.0,
            ),
            Text(
              widget.headerText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            Spacer(),
            Icon(
              expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              color: Colors.white,
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
