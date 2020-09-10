import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/core.dart';
import 'package:pos_app/modules/product_category/product_category_form/controller/product_category_form_controller.dart';

class ProductCategoryFormView extends StatefulWidget {
  @override
  _ProductCategoryFormViewState createState() =>
      _ProductCategoryFormViewState();
}

class _ProductCategoryFormViewState extends State<ProductCategoryFormView> {
  final controller = Get.put(ProductCategoryFormController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductCategoryFormController>(builder: (_) {
      return ExScaffold(
        backgroundColor: Colors.transparent,
        title: "Product Category Form",
        hideAppBar: true,
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              ExTextField(
                id: "product_category_name",
                label: "Product Category Name",
              ),
              Spacer(),
              Row(
                children: [
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      "CANCEL",
                      style: TextStyle(
                        color: ButtonType.disabled,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                        color: ButtonType.warning,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
