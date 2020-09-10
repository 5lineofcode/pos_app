import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';
import 'package:pos_app/xgenerated/generated_router.dart';

Route<dynamic> getRouter(RouteSettings settings) {
  var routeItem =
      GeneratedRouter.routers.where((i) => i.routeName == settings.name).first;

  if (kIsWeb) return sidebarPage(routeItem.web ?? routeItem.layout, settings);

  if (Platform.isAndroid)
    return singlePage(routeItem.android ?? routeItem.layout, settings);

  if (Platform.isIOS) return singlePage(routeItem.ios, settings);

  if (Platform.isFuchsia)
    return singlePage(routeItem.fuchsia ?? routeItem.layout, settings);

  if (Platform.isWindows)
    return sidebarPage(routeItem.windows ?? routeItem.layout, settings);

  if (Platform.isMacOS)
    return sidebarPage(routeItem.mac ?? routeItem.layout, settings);

  if (Platform.isLinux)
    return sidebarPage(routeItem.linux ?? routeItem.layout, settings);

  return sidebarPage(routeItem.layout, settings);
}
