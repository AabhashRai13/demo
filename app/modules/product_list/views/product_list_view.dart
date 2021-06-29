import 'package:bees_pharmacy/app/modules/search_page/views/search_page_view.dart';
import 'package:bees_pharmacy/widgets/Product_single_tile_widget/product_single_tile_Widget.dart';


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../controllers/product_list_controller.dart';

class ProductListView extends GetView<ProductListController> {
  final ProductListController productListController =
      Get.put(ProductListController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Products",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(SearchView());
                },
                child: Text(
                  'View All',
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
            height: 230,
            child: Obx(
              () => productListController.productAvailable.value
                  ? ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                          productListController.products.results.length,
                          (index) {
                        return  ProductSingleTileWidget(
                                  products: productListController
                                      .productResponse[index],
                                  category: "popular",
                                );
                      }))
                  : Center(
                      child: Container(
                      height: 60,
                      width: 60,
                      child: SpinKitCircle(
                        color: Colors.blue[400],
                      ),
                    )),
            )),
      ],
    );
  }
}
