import 'package:bees_pharmacy/app/routes/app_pages.dart';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/widgets/product_wise_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../controllers/category_wise_product_view_controller.dart';

class CategoryWiseProductViewView
    extends GetView<CategoryWiseProductViewController> {
  final CategoryWiseProductViewController categoryWiseProductViewController =
      Get.put(CategoryWiseProductViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            '${categoryWiseProductViewController.categoryName}',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: Get.width,
            child: Column(
              children: [
                SizedBox(
                  height: 18,
                ),
                Obx(() => controller.state == ViewState.Busy
                    ? _buildLoadingWidget()
                    : _buildSuccessWidget()),
              ],
            ),
          ),
        ));
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Container(
        height: Get.height * 0.9,
        child: SpinKitCircle(
          color: Colors.blue[400],
        ),
      ),
    );
  }

  Widget _buildSuccessWidget() {
    return Obx(
      () => categoryWiseProductViewController.productResponse.length == 0
          ? Container(
              height: Get.height * 0.8,
              child: Center(
                  child: Text(
                'No products in this category!',
                style: TextStyle(
                    color: Colors.blue[400],
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              )),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Wrap(
                spacing: 8,
                children: List.generate(
                    categoryWiseProductViewController.productResponse.length,
                    (index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.DETAIL_PAGE,
                          arguments: categoryWiseProductViewController
                              .productResponse[index]);
                    },
                    child:
                    GetBuilder<CategoryWiseProductViewController>(
                    // init: cartController,
                    builder: (controller) =>

                    productWiseContainer(

                        categoryWiseProductViewController
                            .productResponse[index],
                        categoryWiseProductViewController
                            .productResponse[index].name,
                        "",
                        categoryWiseProductViewController
                            .productResponse[index].variant[0].price,
                        categoryWiseProductViewController
                                    .productResponse[index].photos.length <=
                                0
                            ? null
                            : categoryWiseProductViewController
                                .productResponse[index].photos[0].photo,
                        100,
                        156,
                        null,
                        null,
                        categoryWiseProductViewController
                            .productResponse[index].id,
                        categoryWiseProductViewController
                            .productResponse[index].isAdded,
                        null),
                  ));
                }),
              ),
            ),
    );
  }
}
