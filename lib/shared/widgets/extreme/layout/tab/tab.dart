import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExTab {
  static PreferredSizeWidget getTabBar({
    List<Widget> tabs,
    TabController controller,
    dynamic onTap,
  }) {
    List<Widget> newTabs = [];

    var avgWidth = 600 / tabs.length;

    tabs.forEach((tab) {
      newTabs.add(Container(
        constraints: BoxConstraints(
          maxWidth: avgWidth,
        ),
        child: tab,
      ));
    });

    return TabBar(
      controller: controller,
      indicatorColor: Colors.white,
      isScrollable: kIsWeb ? true : false,
      labelPadding: kIsWeb
          ? EdgeInsets.only(
              left: 0,
              right: 0,
            )
          : null,
      tabs: newTabs,
      onTap: (index) {
        if (onTap != null) onTap(index);
      },
    );
  }
}
