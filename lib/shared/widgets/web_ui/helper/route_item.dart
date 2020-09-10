import 'package:flutter/material.dart';

class RouteItem {
  String routeName;
  Widget layout;
  Widget android;
  Widget ios;
  Widget web;
  Widget windows;
  Widget mac;
  Widget linux;
  Widget fuchsia;

  RouteItem({
    @required this.routeName,
    @required this.layout,
    this.android,
    this.ios,
    this.windows,
    this.mac,
    this.linux,
    this.fuchsia,
  });
}
