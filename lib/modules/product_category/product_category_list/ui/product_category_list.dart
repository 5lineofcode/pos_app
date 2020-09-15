import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/core.dart';
import 'package:pos_app/modules/product_category/product_category_form/ui/product_category_form.dart';
import 'package:pos_app/modules/product_category/product_category_list/controller/product_category_list_controller.dart';
import 'package:pos_app/shared/widgets/extreme/reorderable_list/reorderable_list.dart';

class ProductCategoryListView extends StatefulWidget {
  final bool hideAppBar;
  ProductCategoryListView({
    this.hideAppBar = false,
  });

  @override
  _ProductCategoryListViewState createState() =>
      _ProductCategoryListViewState();
}

class _ProductCategoryListViewState extends State<ProductCategoryListView> {
  final controller = Get.put(ProductCategoryListController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductCategoryListController>(builder: (_) {
      return ExScaffold(
        title: "Product Category",
        hideAppBar: widget.hideAppBar,
        floatingActionButton: FloatingActionButton(
          backgroundColor: ButtonType.info,
          child: Icon(Icons.add),
          onPressed: () {
            // Get.to(ProductCategoryFormView());
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  contentPadding: EdgeInsets.all(0.0),
                  content: Container(
                    height: 130.0,
                    child: ProductCategoryFormView(),
                  ),
                );
              },
            );
          },
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Drag to sort items"),
            ),
            Expanded(
              child: ExReorderAbleList(
                items: controller.productCategoryList,
                keyField: "id",
                itemBuilder: (item) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.all(0.0),
                            content: Container(
                              height: 130.0,
                              child: ProductCategoryFormView(),
                            ),
                          );
                        },
                      );
                    },
                    child: Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 14.0,
                          horizontal: 14.0,
                        ),
                        child: Text(item["product_category_name"],
                            style: Theme.of(context).textTheme.subtitle1),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
