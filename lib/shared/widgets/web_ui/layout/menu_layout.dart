import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';



class MenuLayoutScreen extends StatefulWidget {
  final Widget child;
  final String navRouteSelected;
  const MenuLayoutScreen({
    Key key,
    @required this.child,
    @required this.navRouteSelected,
  }) : super(key: key);
  @override
  _MenuLayoutScreenState createState() => _MenuLayoutScreenState();
}

class _MenuLayoutScreenState extends State<MenuLayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Material(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SidebarWeb(
                navRouteSelected: widget.navRouteSelected,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    AppbarWeb(
                      title: "Flutter App",
                    ),
                    Expanded(
                      child: widget.child,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
