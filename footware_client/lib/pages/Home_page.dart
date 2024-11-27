import 'package:flutter/material.dart';
import 'package:footware_client/controller/home_controller.dart';
import 'package:footware_client/pages/login_page.dart';
import 'package:footware_client/pages/product_description.dart';
import 'package:footware_client/widgets/drop_down_btn.dart';
import 'package:footware_client/widgets/multi_select_dropdown.dart';
import 'package:footware_client/widgets/product_card.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async {
          ctrl.fetchProducts();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple.shade50,
            title: Center(
                child: Text(
              "FootWare Store",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
            actions: [
              IconButton(
                  onPressed: () {
                    GetStorage box = GetStorage();
                    box.erase();
                    Get.offAll(LoginPage());
                  },
                  icon: Icon(Icons.logout))
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ctrl.productCategory.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          ctrl.filterByCategory(
                              ctrl.productCategory[index].name ?? "");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Chip(
                              side: BorderSide(color: Colors.grey),
                              label: Text(
                                  ctrl.productCategory[index].name ?? "Error")),
                        ),
                      );
                    }),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: DropdownBtn(
                      items: ["Rs:Low to High", "Rs:High to Low"],
                      selectedItemText: "Sort item",
                      onSelected: (selected) {
                        ctrl.sortByPrice(
                            ascending:
                                selected == 'Rs:Low to High' ? true : false);
                      },
                    ),
                  ),
                  Flexible(
                    child: MultiSelectDropDown(
                      items: [
                        "Puma",
                        "Adidas",
                        "Sketchers",
                        "Reebok",
                        "Clarks",
                        "Nike",
                        "Crocs",
                        "Timberland",
                        "Birkenstock",
                        "Aldo"
                      ],
                      onSelectionChanged: (selectedItems) {
                        ctrl.filterByBrand(selectedItems);
                      },
                    ),
                  )
                ],
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemCount: ctrl.productShowUi.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      name: ctrl.productShowUi[index].name ?? "No name",
                      imageUrl: ctrl.productShowUi[index].image ?? "url",
                      price: ctrl.productShowUi[index].price ?? 00,
                      offerTag: '41% off',
                      onTap: () {
                        Get.to(ProductDescriptionPage(),
                            arguments: {'data': ctrl.productShowUi[index]});
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
