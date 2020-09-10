import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class ItemGenerator {
  static List exception = [
    "id",
    "company_id",
    "created_at",
    "updated_at",
    "company"
  ];

  static onItemBuilder(BuildContext context, int index, List items) {
    var item = items[index];
    List<Widget> itemViews = [];

    item.forEach((key, value) {
      if (exception.contains(key)) return Container();

      try {
        itemViews.add(Text("LIST"));
        return Container();
      } catch (e) {
        debugPrint(e);
      }

      if (value is Map) {
        itemViews.add(CrudItemTemplate.getMapTemplate(key, value));
        return Container();
      }

      if (value is List) {
        itemViews.add(Text("LIST"));
        return Container();
      }

      if (key.contains("photo")) {
        itemViews.add(
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("$key"),
                if (value.length > 6)
                  Image.network(
                    "${AppSession.hostUrl}$value",
                    width: 120,
                    height: 120,
                  ),
                if (value.length < 6)
                  Image.asset(
                    "assets/images/no_photo.png",
                    width: 120,
                    height: 120,
                  ),
              ],
            ),
          ),
        );
      } else {
        itemViews.add(
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("$key"),
                Text("$value"),
              ],
            ),
          ),
        );
      }
      return Container();
    });

    return ItemCard(
      title: "#" + item["id"].toString(),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: itemViews,
        ),
      ],
    );
  }
}
