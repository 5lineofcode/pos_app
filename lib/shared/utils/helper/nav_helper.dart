import 'package:flutter/material.dart';

class NavHelper {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName,
      {Map<String, String> queryParams}) {
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }
    return navigatorKey.currentState.pushNamed(routeName);
  }

  goBack() {
    return navigatorKey.currentState.pop();
  }
}

NavHelper navHelper = NavHelper();