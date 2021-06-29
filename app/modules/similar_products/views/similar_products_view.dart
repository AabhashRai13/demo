import 'dart:ui';

import 'package:bees_pharmacy/widgets/Product_single_tile_widget/product_single_tile_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../controllers/similar_products_controller.dart';

class SimilarProductsView extends GetView<SimilarProductsController> {
  final SimilarProductsController similarProductsController =
      Get.put(SimilarProductsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: 230,
            child: Obx(
              () => similarProductsController.productAvailable.value
                  ? similarProductsController.productResponse.length == 0
                      ? Center(
                          child: Text(
                            'No related products!',
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          ),
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                              similarProductsController
                                  .similarProducts.results.length, (index) {
                            return ProductSingleTileWidget(
                              products: similarProductsController
                                  .productResponse[index],
                            );
                          }))
                  : Center(
                      child: Container(
                      height: 60,
                      width: 60,
                      child: SpinKitCircle(
                        color: Colors.blue,
                      ),
                    )),
            )),
      ],
    );
  }
}
