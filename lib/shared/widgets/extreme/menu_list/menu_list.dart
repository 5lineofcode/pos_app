import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class ExMenuList extends StatefulWidget {
  final List menuList;

  ExMenuList({
    @required this.menuList,
  });
  @override
  _ExMenuListState createState() => _ExMenuListState();
}

class _ExMenuListState extends State<ExMenuList> {
  List<Color> colorPalletes = [
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.black,
    Colors.teal,
    Colors.blue,
    Colors.grey,
    Colors.green,
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        runAlignment: WrapAlignment.start,
        children: List.generate(widget.menuList.length, (index) {
          var item = widget.menuList[index];

          return InkWell(
            onTap: () {
              navHelper.navigateTo(item["page"]);
            },
            child: Container(
              padding: EdgeInsets.all(2.0),
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width / 5,
              child: Column(
                children: <Widget>[
                  Icon(
                    item["icon"],
                    color: colorPalletes[index],
                    size: 26.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    item["label"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
