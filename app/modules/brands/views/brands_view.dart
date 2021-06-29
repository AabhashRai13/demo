import 'package:bees_pharmacy/app/modules/brands_list/views/brands_list_view.dart';
import 'package:bees_pharmacy/app/modules/brands/controllers/brands_controller.dart';
import 'package:bees_pharmacy/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BrandsView extends GetView {
  final BrandsController brandsController = Get.put(BrandsController());
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
                  "Brands",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => BrandsListView());
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
              () => brandsController.brandsAvailable.value
                  ? ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        brandsController.brandsResponse.length,
                        (index) {
                          return InkWell(
                            onTap: () => Get.toNamed(
                                Routes.BRAND_WISE_PRODUCT_VIEW,
                                arguments: brandsController
                                    .brandsResponse[index].name),
                            child: Container(
                              width: 100,
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
                                      image: DecorationImage(
                                        image: brandsController
                                                    .brandsResponse[index]
                                                    .image !=
                                                null
                                            ? NetworkImage(brandsController
                                                .brandsResponse[index].image)
                                            : AssetImage('assets/loading.gif'),
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
                                        brandsController
                                            .brandsResponse[index].name,
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
