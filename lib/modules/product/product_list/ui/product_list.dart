import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/core.dart';
import 'package:pos_app/modules/product/product_form/ui/product_form.dart';
import 'package:pos_app/modules/product/product_list/controller/product_list_controller.dart';
import 'package:pos_app/modules/product_category/product_category_list/ui/product_category_list.dart';

class ProductListView extends StatefulWidget {
  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final controller = Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductListController>(builder: (_) {
      return DefaultTabController(
        length: 2,
        child: ExScaffold(
          title: "Product",
          actions: [
            ActionIcon(
              icon: Icons.more_vert,
              color: ButtonType.warning,
              onTap: () {},
            ),
          ],
          // bottom: TabBar(
          //   tabs: [
          //     Tab(
          //       child: Text("Product"),
          //     ),
          //     Tab(
          //       child: Text("Category"),
          //     ),
          //   ],
          // ),
          body: Column(
            children: [
              Container(
                color: Colors.white,
                child: TabBar(
                  indicatorColor: Color(0xffe54535),
                  indicatorWeight: 4,
                  tabs: [
                    Tab(
                      child: Text("Product"),
                    ),
                    Tab(
                      child: Text("Category"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Scaffold(
                      floatingActionButton: FloatingActionButton(
                        backgroundColor: ButtonType.warning,
                        child: Icon(Icons.add),
                        onPressed: () {
                          Get.to(ProductFormView());
                        },
                      ),
                      body: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 50.0,
                                    color: Color(0xfff3f4f8),
                                    child: ExTextField(
                                      id: "",
                                      label: "",
                                      hideLabel: true,
                                      icon: Icons.search,
                                      hintText: "Search Product",
                                      useIcon: true,
                                      backgroundColor: Color(0xfff3f4f8),
                                      textColor: Color(0xffaaabaf),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                ActionIcon(
                                  icon: Icons.tune,
                                  color: ButtonType.warning,
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                itemCount: controller.productList.length,
                                itemBuilder: (context, index) {
                                  var item = controller.productList[index];

                                  return InkWell(
                                    onTap: () => Get.to(ProductFormView()),
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 10.0),
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 0.6,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 80.0,
                                            height: 80.0,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image:
                                                    NetworkImage(item["image"]),
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.0)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8.0,
                                              top: 10.0,
                                              bottom: 10.0,
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  item["product_name"],
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8.0,
                                              top: 10.0,
                                              bottom: 10.0,
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Stock",
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                                Text(
                                                  item["stock"].toString(),
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ProductCategoryListView(
                      hideAppBar: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
