import 'package:get/get.dart';

class ProductListController extends GetxController {
  var productList = [
    {
      "product_name": "Vanish",
      "image":
          "https://ecs7.tokopedia.net/img/cache/700/product-1/2020/3/6/5513791/5513791_8382e903-6117-4d2f-9e18-13777edce915_1728_1728.jpg",
      "price": 15500,
      "stock": 100,
    },
    {
      "product_name": "GG Filter 12",
      "image":
          "https://d1d8o7q9jg8pjk.cloudfront.net/p/lg_5e7e9e806bf34.jpeg",
      "price": 13500,
      "stock": 54,
    },
  ];

  increment() {
    update();
  }
}
