import 'package:bees_pharmacy/app/modules/baby_products/controllers/baby_products_controller.dart';
import 'package:bees_pharmacy/app/modules/baby_products/views/baby_products_view.dart';
import 'package:bees_pharmacy/app/modules/product_list/views/product_list_view.dart';
import 'package:bees_pharmacy/app/views/views/category_list_view.dart';
import 'package:bees_pharmacy/widgets/Container_widget.dart';
import 'package:flutter/material.dart';
import 'package:bees_pharmacy/app/modules/brands/views/brands_view.dart';

import 'package:get/get.dart';

class AllProductListView extends GetView {
  final BabyProductsController babyProductsController =
      Get.put(BabyProductsController());
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4.0,
            vertical: 2,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: banContainer(100, Get.width, 'assets/Image3.png'),
              ),
              CategoryListView(),
              SizedBox(
                height: 6,
              ),
              ProductListView(),
              SizedBox(
                height: 6,
              ),
              BrandsView(),
              SizedBox(
                height: 6,
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: banContainer(200, Get.width, 'assets/Image4.png'),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 20,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {
                        // Get.to(() => ViewAllView());
                      },
                      child: Text('Buy Now'),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              BabyProductsView(),
            ],
          ),
        ),
      ),
    );
  }
}

inputSearch() {
  return Row(
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 16),
          decoration: BoxDecoration(
              color: Colors.blueGrey[100].withOpacity(0.16),
              borderRadius: BorderRadius.circular(38)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: TextFormField(
              autofocus: false,
              maxLines: 1,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.lightBlueAccent,
                icon: Icon(
                  Icons.search,
                  color: Colors.red[400],
                ),
                hintText: 'Search',
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
