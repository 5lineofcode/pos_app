import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/app.dart';
import 'package:pos_app/modules/product/product_list/ui/product_list.dart';
import 'package:pos_app/modules/product_category/product_category_list/ui/product_category_list.dart';

class MainDashboardController extends GetxController {
  List menuList = [
    {
      "name": "Product",
      "icon": FontAwesomeIcons.box,
      "color": Colors.green,
      "page": ProductListView(),
    },
    {
      "name": "Product Category",
      "icon": FontAwesomeIcons.puzzlePiece,
      "color": Colors.red,
      "page": ProductCategoryListView(),
    },
    {
      "name": "About Us",
      "icon": FontAwesomeIcons.userNinja,
      "color": Colors.orange,
    }
  ];

  var count = 0;
  increment() {
    count += 1;
    update();
  }
}
