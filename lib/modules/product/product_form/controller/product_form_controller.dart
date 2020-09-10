import 'package:get/get.dart';
import 'package:pos_app/modules/product_category/product_category_list/controller/product_category_list_controller.dart';

class ProductFormController extends GetxController {
  final productCategoryController = Get.put(ProductCategoryListController());
  bool updateStockAndCogs = false;

  doUpdateStockAndCogs(newValue) {
    updateStockAndCogs = newValue;
    update();
  }

  getProductCategoryItems() {
    List items = [];
    productCategoryController.productCategoryList.forEach((item) {
      items.add({
        "label": item["product_category_name"],
        "value": item["product_category_name"],
      });
    });
    return items;
  }
}
