import 'package:bees_pharmacy/app/modules/brands/controllers/brands_controller.dart';
import 'package:bees_pharmacy/app/routes/app_pages.dart';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/widgets/Container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../controllers/brands_list_controller.dart';

class BrandsListView extends GetView<BrandsListController> {
  final BrandsController brandsController = Get.put(BrandsController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              constraints: BoxConstraints(),
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.arrow_back_ios,
                size: 18,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Brands',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: GetBuilder<BrandsController>(
                init: BrandsController(),
                builder: (builder) => builder.state == ViewState.Busy
                    ? _buildLoadingWidget()
                    : _buildSuccessWidget()),
          )),
    );
  }

  Widget _buildLoadingWidget() {
    return SpinKitCircle(color: Colors.blue);
  }

  Widget _buildSuccessWidget() {
    return Container(
      width: Get.width,
      child: Column(
        children: [
          SizedBox(
            height: 18,
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Wrap(
                spacing: 8,
                children: List.generate(brandsController.brandsResponse.length,
                    (index) {
                  return InkWell(
                    onTap: () => Get.toNamed(Routes.BRAND_WISE_PRODUCT_VIEW,
                        arguments: brandsController.brandsResponse[index].name),
                    child: productContainer(
                        brandsController.brandsResponse[index].name,
                        null,
                        null,
                        brandsController.brandsResponse[index].image == null
                            ? null
                            : brandsController.brandsResponse[index].image,
                        100,
                        156,
                        null,
                        null,
                        null,
                        null),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
