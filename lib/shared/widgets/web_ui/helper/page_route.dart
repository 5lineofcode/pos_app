import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';



PageRoute getPageRoute(Widget child, RouteSettings settings) {
  return FadeRoute(child: child, routeName: settings.name);
}

PageRoute singlePage(Widget child, RouteSettings settings) {
  return getPageRoute(child, settings);
}

PageRoute sidebarPage(Widget child, RouteSettings settings) {
  var routingData = settings.name.getRoutingData;
  return getPageRoute(
      MenuLayoutScreen(
        navRouteSelected: routingData.route,
        child: child,
      ),
      settings);
}
