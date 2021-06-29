import 'package:bees_pharmacy/app/routes/app_pages.dart';
import 'package:bees_pharmacy/widgets/product_wise_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../controllers/brand_wise_product_view_controller.dart';

class BrandWiseProductView extends GetView<BrandWiseProductViewController> {
  final BrandWiseProductViewController brandWiseProductViewController =
      Get.put(BrandWiseProductViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            '${brandWiseProductViewController.brandName}',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 18,
                ),
                Obx(
                  () => brandWiseProductViewController.productAvailable.value
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Wrap(
                              spacing: 8,
                              children: List.generate(
                                  brandWiseProductViewController
                                      .productResponse.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.DETAIL_PAGE,
                                        arguments:
                                            brandWiseProductViewController
                                                .productResponse[index]);
                                  },
                                  child: productWiseContainer(
                                      brandWiseProductViewController
                                          .productResponse[index],
                                      brandWiseProductViewController
                                          .productResponse[index].name,
                                      "",
                                      brandWiseProductViewController
                                          .productResponse[index]
                                          .variant[0]
                                          .price,
                                      brandWiseProductViewController
                                                  .productResponse[index]
                                                  .photos
                                                  .length <=
                                              0
                                          ? null
                                          : brandWiseProductViewController
                                              .productResponse[index]
                                              .photos[0]
                                              .photo,
                                      100,
                                      156,
                                      null,
                                      null,
                                       brandWiseProductViewController
                                          .productResponse[index].id,
                                      brandWiseProductViewController
                                              .productResponse[index]
                                              .isAdded,
                                      null),
                                );
                              })),
                        )
                      : Center(
                          child: Container(
                            height: Get.height * 0.9,
                            child: SpinKitCircle(
                              color: Colors.blue[400],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ));
  }
}
