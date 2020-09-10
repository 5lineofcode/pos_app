import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/core.dart';
import 'package:pos_app/modules/product/product_form/controller/product_form_controller.dart';

class ProductFormView extends StatefulWidget {
  @override
  _ProductFormViewState createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<ProductFormView> {
  final controller = Get.put(ProductFormController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductFormController>(builder: (_) {
      return ExScaffold(
        title: "Product Form",
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  top: 8.0,
                  bottom: 8.0,
                ),
                color: Colors.white,
                child: Column(
                  children: [
                    ExTextField(
                      id: "product_name",
                      label: "Product Name",
                    ),
                    ExCombo(
                      id: "brand",
                      label: "Brand",
                      items: [
                        {
                          "label": "No Brand",
                          "value": "No Brand",
                        },
                        {
                          "label": "Nokia",
                          "value": "Nokia",
                        }
                      ],
                    ),
                    ExCombo(
                      id: "product_category",
                      label: "Product Category",
                      items: controller.getProductCategoryItems(),
                    ),
                    ExTextField(
                      id: "price",
                      label: "Price",
                      keyboardType: TextInputType.number,
                      value: "0",
                    ),
                  ],
                ),
              ),
              Container(
                height: 10.0,
                color: Colors.grey[300],
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  top: 8.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                       padding: const EdgeInsets.only(
                          top: 8.0,
                        ),
                        child: Text(
                          "Update Stock & COGS",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ),
                    Switch(
                      activeColor: ButtonType.warning,
                      value: controller.updateStockAndCogs,
                      onChanged: (newValue) {
                        controller.doUpdateStockAndCogs(newValue);
                      },
                    ),
                  ],
                ),
              ),
              if (controller.updateStockAndCogs)
                Container(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    right: 18.0,
                    top: 8.0,
                    bottom: 8.0,
                  ),
                  color: Colors.white,
                  child: Column(
                    children: [
                      ExTextField(
                        id: "cogs",
                        label: "COGS (Cost of Goods Sold)",
                        keyboardType: TextInputType.number,
                        value: "0",
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: ExTextField(
                              id: "barcode",
                              label: "Barcode",
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            height: 46.0,
                            child: ExButton(
                              label: "Scan",
                              type: ButtonType.disabled,
                              icon: FontAwesomeIcons.barcode,
                              iconColor: Colors.grey[800],
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: Get.width,
                        padding: const EdgeInsets.only(
                          top: 8.0,
                        ),
                        child: Text(
                          "Stock",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                      ExTextField(
                        id: "stock",
                        label: "Stock Amount",
                        keyboardType: TextInputType.number,
                        value: "0",
                      ),
                      ExCombo(
                        id: "unit",
                        label: "Unit",
                        items: [
                          {
                            "label": "PCS",
                            "value": "PCS",
                          },
                          {
                            "label": "PAK",
                            "value": "PAK",
                          }
                        ],
                      ),
                    ],
                  ),
                ),
              Container(
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                ),
                width: Get.width,
                child: ExButton(
                  label: "Add Variant",
                  type: Colors.grey[300],
                  textColor: Colors.grey[800],
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
            width: Get.width,
            height: 70.0,
            padding: EdgeInsets.all(10.0),
            child: ExButton(
              label: "Save",
              type: ButtonType.warning,
              onPressed: () {},
            )),
      );
    });
  }
}
