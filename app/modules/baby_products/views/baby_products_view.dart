import 'package:bees_pharmacy/app/modules/search_page/views/search_page_view.dart';
import 'package:bees_pharmacy/widgets/Product_single_tile_widget/product_single_tile_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../controllers/baby_products_controller.dart';

class BabyProductsView extends GetView<BabyProductsController> {
final BabyProductsController babyProductsController= Get.put(BabyProductsController());

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
                "Baby Products",
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
                  "View All",
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
            height: 230,
            child: Obx(
              () => babyProductsController.productAvailable.value
                  ? ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                          babyProductsController.products.results.length,
                          (index) {
                        return GetBuilder<BabyProductsController>(
                            // init: cartController,
                            builder: (controller) => ProductSingleTileWidget(
                          products:
                          babyProductsController.productResponse[index],
                              category: "baby",
                        ));
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
