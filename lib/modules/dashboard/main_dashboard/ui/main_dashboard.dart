import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/core.dart';
import 'package:pos_app/modules/dashboard/main_dashboard/controller/main_dashboard_controller.dart';

class MainDashboardView extends StatefulWidget {
  @override
  _MainDashboardViewState createState() => _MainDashboardViewState();
}

class _MainDashboardViewState extends State<MainDashboardView> {
  final controller = Get.put(MainDashboardController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainDashboardController>(builder: (_) {
      return ExScaffold(
        title: "Dashboard",
        actions: [
          ActionIcon(
            icon: Icons.notifications,
            notifyCount: Random().nextInt(80),
            color: TS.getHeaderTextColor(),
            onTap: () {},
          ),
        ],
        body: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: Get.width,
                child: Wrap(
                  children: List.generate(
                    controller.menuList.length,
                    (index) {
                      var item = controller.menuList[index];
                      return MenuIcon(item: item);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class MenuIcon extends StatelessWidget {
  final dynamic item;
  const MenuIcon({
    @required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (item["page"] != null) {
          Get.to(item["page"]);
        }
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        width: Get.width / 5,
        height: 80.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item["icon"],
              color: item["color"],
            ),
            SizedBox(
              height: 12.0,
            ),
            Expanded(
              child: Text(
                item["name"],
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
