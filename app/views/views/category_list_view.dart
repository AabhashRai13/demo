import 'package:bees_pharmacy/app/modules/category/controllers/category_controller.dart';
import 'package:bees_pharmacy/app/modules/category/views/category_view.dart';
import 'package:bees_pharmacy/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CategoryListView extends GetView {
  final CategoryController categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Category",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(CategoryView());
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
            height: 100,
            child: Obx(
              () => categoryController.categoriesAvailable.value
                  ? ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        categoryController.categoriesResponse.length,
                        (index) {
                          return InkWell(
                            onTap: () => Get.toNamed(
                                Routes.CATEGORY_WISE_PRODUCT_VIEW,
                                arguments: categoryController
                                    .categoriesResponse[index].title),
                            child: Container(
                              width: 100,
                              // margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      image: categoryController
                                                  .categoriesResponse[index]
                                                  .image ==
                                              null
                                          ? DecorationImage(
                                              image: AssetImage(
                                                  "assets/loading.gif"))
                                          : DecorationImage(
                                              image: NetworkImage(
                                                  categoryController
                                                      .categoriesResponse[index]
                                                      .image),
                                              fit: BoxFit.cover,
                                            ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          offset: Offset(0, 0),
                                          spreadRadius: 1,
                                          blurRadius: 4,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    width: 75,
                                    height: 20,
                                    child: Center(
                                      child: Text(
                                        categoryController
                                            .categoriesResponse[index].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : SizedBox(),
            ),
          )
        ],
      ),
    );
  }
}
