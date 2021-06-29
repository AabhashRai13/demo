import 'package:bees_pharmacy/app/modules/wishlist_icon/views/wishlist_icon_view.dart';
import 'package:bees_pharmacy/app/routes/app_pages.dart';
import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/utils/wishlist_service_api.dart';
import 'package:bees_pharmacy/widgets/widet_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';

class SimilarWidget extends GetView {
  final products;

  SimilarWidget({this.products});

 final WishListServiceApi wishListService = locator<WishListServiceApi>();
  var isAdded = false.obs;

  String brandName() {
    if (products.brand == null) {
      return "N/A";
    } else {
      return products.brand.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    isAdded.value = products.isAdded;
    return InkWell(
      onTap: () {
        Get.offAndToNamed(Routes.DETAIL_PAGE_2, arguments: products);
      },
      child: Row(
        children: [
          SizedBox(
            width: 16,
          ),
          Container(
            width: 156,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.only(right: 0.0, top: 10, bottom: 10, left: 0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: Offset(0, 0),
                    blurRadius: 3,
                    spreadRadius: 1,
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WishListIconView(
                  product: products,
                ),
                SizedBox(
                  height: 100,
                  child: Center(
                    child: imageContainer(
                        products.photos.length <= 0
                            ? null
                            : products.photos[0].photo,
                        products),
                  ),
                ),
                gap(10, 0),
                Text(
                  products.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                ),
                SizedBox(
                  height: 20,
                  width: Get.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Text(
                        "Brand: ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                      ),
                      Text(
                        brandName(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                gap(2, 0),
                SizedBox(
                  height: 20,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      products.variant.length == 0
                          ? Text("")
                          : Text(
                              "Rs ${products.variant[0].price.toString()}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              maxLines: 1,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 6,
          ),
        ],
      ),
    );
  }
}
