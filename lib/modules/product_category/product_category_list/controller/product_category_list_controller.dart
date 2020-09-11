import 'package:get/get.dart';

class ProductCategoryListController extends GetxController {
  var productCategoryList = [
    {
      "id": "1",
      "product_category_name": "Umum",
    },
    {
      "id": "2",
      "product_category_name": "Sabun",
    },
    {
      "id": "3",
      "product_category_name": "Sembako",
    },
  ];

  increment() {
    update();
  }
}
