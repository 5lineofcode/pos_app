import 'package:get/get.dart';

class ProductCategoryListController extends GetxController {
  var productCategoryList = [
    {
      "product_category_name": "Umum",
    },
    {
      "product_category_name": "Sabun",
    },
    {
      "product_category_name": "Sembako",
    },
  ];

  increment() {
    update();
  }
}
