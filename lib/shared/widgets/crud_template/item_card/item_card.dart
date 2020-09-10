import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class ItemCard extends StatefulWidget {
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

  ItemCard({
    this.children = const [],
    this.title,
    this.bottom = const [],
    this.bottomStyle = SpaceStyle.spaceBetween,
    this.width = 200,
    this.showClose = false,
    this.headerBackground,
    this.headerTextColor,
    this.maxHeight,
    this.contentPadding,
  });

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  List<Widget> _bottom = [];

  @override
  void initState() {
    super.initState();
    _bottom = widget.bottom;
  }

  getRowContainer() {
    return Row(
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
        InkWell(
          onTap: () => hideOverlay,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              Icons.edit,
              size: 16.0,
              color: Colors.orange[400],
            ),
          ),
        ),
        InkWell(
          onTap: () => hideOverlay,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              FontAwesomeIcons.trash,
              size: 16.0,
              color: Colors.red[400],
            ),
          ),
        ),
      ],
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
      padding: EdgeInsets.all(widget.contentPadding ?? 8.0),
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
    if (_bottom.isEmpty) return Container();

    if (widget.bottomStyle == SpaceStyle.spaceBetween) {
      for (var i = 1; i < _bottom.length; i++) {
        _bottom[i] = Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.only(left: 10.0),
          child: _bottom[i],
        );
      }
    } else if (widget.bottomStyle == SpaceStyle.expandedSpaceBetween) {
      for (var i = 0; i < _bottom.length; i++) {
        _bottom[i] = Expanded(
          child: Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.only(left: i == 0 ? 0 : 10.0),
            child: _bottom[i],
          ),
        );
      }
    }

    return Container(
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: _bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
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
