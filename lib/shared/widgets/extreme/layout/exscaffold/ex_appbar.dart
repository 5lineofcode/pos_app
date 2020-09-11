import 'package:flutter/material.dart';

class ExAppBar {
  static PreferredSizeWidget getAppBar({
    BuildContext context,
    String title = "",
    List<Widget> actions = const [],
    PreferredSizeWidget bottom,
  }) {
    return AppBar(
      title: Text(title),
      elevation: 1.0,
      actions: actions,
      bottom: bottom,
    );
  }

  static PreferredSizeWidget getSearchAppBar(context) {
    var theme = Theme.of(context);
    return AppBar(
      leading: InkWell(
        onTap: () {},
        child: Icon(
          Icons.arrow_back,
          color: theme.primaryColor,
        ),
      ),
      title: TextField(
        autofocus: true,
        decoration: InputDecoration.collapsed(
          hintText: "Search",
        ),
      ),
    );
  }
}
