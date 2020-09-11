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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExReorderAbleList(
            items: controller.productCategoryList,
            keyField: "id",
          ),
          // child: ListView.builder(
          //   itemCount: controller.productCategoryList.length,
          //   itemBuilder: (context, index) {
          //     var item = controller.productCategoryList[index];

          //     return Container(
          //       margin: EdgeInsets.only(bottom: 10.0),
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         border: Border(
          //           bottom: BorderSide(
          //             width: 0.6,
          //             color: Colors.grey,
          //           ),
          //           top: BorderSide(
          //             width: 0.6,
          //             color: Colors.grey,
          //           ),
          //           left: BorderSide(
          //             width: 0.6,
          //             color: Colors.grey,
          //           ),
          //           right: BorderSide(
          //             width: 0.6,
          //             color: Colors.grey,
          //           ),
          //         ),
          //       ),
          //       child: Row(
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.only(
          //               left: 8.0,
          //               right: 8.0,
          //               top: 10.0,
          //               bottom: 10.0,
          //             ),
          //             child: Icon(Icons.drag_handle),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.only(
          //               left: 8.0,
          //               right: 8.0,
          //               top: 10.0,
          //               bottom: 10.0,
          //             ),
          //             child: Column(
          //               children: [
          //                 Text(
          //                   item["product_category_name"],
          //                   style: TextStyle(
          //                     fontSize: 16.0,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Spacer(),
          //           Padding(
          //             padding: const EdgeInsets.only(
          //               left: 8.0,
          //               right: 8.0,
          //               top: 10.0,
          //               bottom: 10.0,
          //             ),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Icon(
          //                   Icons.edit,
          //                   color: ButtonType.warning,
          //                   size: 28.0,
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // ),
        ),
      );
    });
  }
}
