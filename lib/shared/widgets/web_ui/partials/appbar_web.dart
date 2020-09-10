import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class AppbarWeb extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWeb({
    this.leading,
    @required this.title,
    Key key,
  }) : super(key: key);

  final String title;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.1,
      titleSpacing: 0,
      leading: leading,
      title: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      // backgroundColor: TS.getPrimaryColor(),
      backgroundColor: Colors.grey[900],
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton.icon(
              color: Colors.red,
              icon: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Colors.white,
                size: 16.0,
              ),
              label: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
              onPressed: () async {
                // debugPrint("logout?");
                await LocalStorage.clearLocalStorage();
                Helper.pushReplacementNamed(context, '/login');
              }),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
