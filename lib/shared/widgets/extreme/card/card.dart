import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class ExCard extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final List<Widget> bottom;
  final SpaceStyle bottomStyle;
  final double width;
  final double maxHeight;

  final bool showClose;

  final Color headerBackground;
  final Color headerTextColor;

  final double contentPadding;

  ExCard({
    this.children = const [],
    this.title,
    this.bottom = const [],
    this.bottomStyle = SpaceStyle.expandedSpaceBetween,
    this.width = 200,
    this.showClose = false,
    this.headerBackground,
    this.headerTextColor,
    this.maxHeight,
    this.contentPadding,
  });

  @override
  _ExCardState createState() => _ExCardState();
}

class _ExCardState extends State<ExCard> {
  @override
  void initState() {
    super.initState();
  }

  getRowContainer() {
    return Container(
      padding: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 6.0,
        top: 6.0,
      ),
      child: Row(
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(
              color: widget.headerTextColor ?? Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          Spacer(),
          // InkWell(
          //   onTap: () => hideOverlay,
          //   child: Padding(
          //     padding: const EdgeInsets.all(4.0),
          //     child: Icon(
          //       Icons.edit,
          //       size: 16.0,
          //       color: Colors.orange[400],
          //     ),
          //   ),
          // ),
          // InkWell(
          //   onTap: () => hideOverlay,
          //   child: Padding(
          //     padding: const EdgeInsets.all(4.0),
          //     child: Icon(
          //       FontAwesomeIcons.trash,
          //       size: 16.0,
          //       color: Colors.red[400],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  getChildrenContainer() {
    return getRowContainer();
  }

  getHeader() {
    if (widget.title == null) return Container();

    return Container(
      padding: EdgeInsets.all(8.0),
      child: getChildrenContainer(),
      decoration: BoxDecoration(
        color: widget.headerBackground ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
    );
  }

  getBody() {
    if (widget.children.isEmpty) return Container();

    return Container(
      // padding: EdgeInsets.all(widget.contentPadding ?? 8.0),
      padding: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        top: 8.0,
      ),
      constraints: BoxConstraints(
        maxHeight:
            widget.maxHeight != null ? widget.maxHeight : double.infinity,
      ),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: widget.children,
          ),
        ),
      ),
    );
  }

  getBottom() {
    if (widget.bottom.isEmpty) return Container();

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: widget.bottom,
      ),
      padding: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
      ),
    );
  }

  MediaQueryData mediaQuery;
  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context);

    return Container(
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[300],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            8.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getHeader(),
          getBody(),
          getBottom(),
        ],
      ),
    );
  }
}
