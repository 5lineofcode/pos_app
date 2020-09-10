import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';
import 'package:pos_app/xgenerated/generated_sidebar_menu.dart';

class SidebarWeb extends StatefulWidget {
  SidebarWeb({
    Key key,
    @required this.navRouteSelected,
    this.onMenuSelected,
  });
  final String navRouteSelected;
  final Function(int) onMenuSelected;

  @override
  _SidebarWebState createState() => _SidebarWebState();
}

class _SidebarWebState extends State<SidebarWeb>
    with SingleTickerProviderStateMixin {
  double maxWidth = 200;
  double minWidgth = 70;
  bool collapsed = false;
  int selectedIndex = 0;

  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this,
    );

    _animation = Tween<double>(begin: maxWidth, end: minWidgth)
        .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(blurRadius: 10, color: Colors.black26, spreadRadius: 2)
            ],
            color: Colors.grey[800],
          ),
          width: _animation.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 17,
              ),
              Expanded(
                child: menuList(),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        );
      },
    );
  }

  ListView menuList() {
    List<Menu> menuListItem = GeneratedSidebarMenu.getWebSidebarMenu();

    return ListView.separated(
      separatorBuilder: (context, counter) {
        return Divider(
          height: 2,
        );
      },
      itemCount: menuListItem.length,
      itemBuilder: (BuildContext context, int index) {
        return MenuItemTile(
          title: menuListItem[index].title,
          icon: menuListItem[index].icon,
          animationController: _animationController,
          isSelected: widget.navRouteSelected == menuListItem[index].navRoute,
          onTap: () {
            navHelper.navigateTo(menuListItem[index].navRoute);
          },
        );
      },
    );
  }
}
