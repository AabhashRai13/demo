import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/widgets/Container_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  final CategoryController categoryController = Get.put(CategoryController());
  final cardHeight = 160;
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
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          body: GetBuilder<CategoryController>(
              // init: CategoryController(),
              builder: (builder) => builder.state == ViewState.Busy
                  ? _buildLoadingWidget()
                  : _buildSuccessWidget())),
    );
  }

  Widget _buildLoadingWidget() {
    return SpinKitCircle(color: Colors.blue);
  }

  Widget _buildSuccessWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 18,
          ),
          Center(
            child: Text(
              'All Categories',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Obx(
            () => Wrap(
              spacing: 6,
              children: List.generate(
                categoryController.categoriesResponse.length,
                (index) {
                  return InkWell(
                    onTap: () => Get.toNamed(Routes.CATEGORY_WISE_PRODUCT_VIEW,
                        arguments:
                            categoryController.categoriesResponse[index].title),
                    child: productContainer(
                        categoryController.categoriesResponse[index].title,
                        'productDesc',
                        null,
                        categoryController.categoriesResponse[index].image ==
                                null
                            ? null
                            : categoryController
                                .categoriesResponse[index].image,
                        categoryController.categoriesResponse[index].image ==
                                null
                            ? 100
                            : 100,
                        156,
                        null,
                        null,
                        null,
                        null),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
