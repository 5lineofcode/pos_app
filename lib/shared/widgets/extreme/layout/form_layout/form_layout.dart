import 'package:flutter/material.dart';

class ExFormLayout extends StatefulWidget {
  final List<Widget> children;
  final List<Widget> header;
  final List<Widget> footer;
  final double maxWidth;

  ExFormLayout({
    this.header = const [],
    this.children = const [],
    this.footer = const [],
    this.maxWidth,
  });

  @override
  _ExFormLayoutState createState() => _ExFormLayoutState();
}

class _ExFormLayoutState extends State<ExFormLayout> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        constraints: widget.maxWidth != null
            ? BoxConstraints(maxWidth: widget.maxWidth)
            : null,
        child: Column(
          children: [
            if (widget.header.isNotEmpty)
              Container(
                padding: EdgeInsets.all(12.0),
                height: 50.0,
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.header,
                ),
              ),
            Container(
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: widget.children,
              ),
            ),
            if (widget.footer.isNotEmpty)
              Container(
                padding: EdgeInsets.all(12.0),
                height: 50.0,
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.footer,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
