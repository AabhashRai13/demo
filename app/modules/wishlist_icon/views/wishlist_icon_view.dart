import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/storage/sharedprefences/shared_preferences_manager.dart';
import 'package:bees_pharmacy/utils/wishlist_service_api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';

import '../controllers/wishlist_icon_controller.dart';

class WishListIconView extends GetView {
  final product;
  final category;

  WishListIconView({this.product, this.category});

  final WishlistIconController wishListIconController =
      Get.put(WishlistIconController());

 final WishListServiceApi wishListServiceApi = locator<WishListServiceApi>();

  @override
  Widget build(BuildContext context) {
    return locator<SharedPreferencesManager>().isKeyExists('isLogin') == true
        ? Obx(() => wishListServiceApi.wishListResponse
                .any((element) => element.id == product.id)
            ? IconButton(
                splashRadius: 3,
                constraints: BoxConstraints(),
                padding: EdgeInsets.all(0),
                icon: Icon(
                  Icons.favorite,
                  size: 18,
                  color: Colors.blue,
                ),
                onPressed: wishListServiceApi.state == ViewState.Busy
                    ? () {}
                    : () async {
                         await wishListServiceApi
                            .deleteWishListItem(product.id, category);
                      },
              )
            : IconButton(
                splashRadius: 3,
                constraints: BoxConstraints(),
                padding: EdgeInsets.all(0),
                icon: Icon(
                  Icons.favorite_border,
                  size: 18,
                  color: Colors.blue,
                ),
                onPressed: wishListServiceApi.state == ViewState.Busy
                    ? () {}
                    : () async {
                         await wishListServiceApi.addToWishList(
                            product.id, category, product);
                      }))
        : IconButton(
            splashRadius: 3,
            constraints: BoxConstraints(),
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.favorite_border,
              size: 18,
              color: Colors.blue,
            ),
            onPressed: wishListServiceApi.state == ViewState.Busy
                ? () {}
                : () {
                    Fluttertoast.showToast(
                        msg: "Please login to add product to wishlist",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        backgroundColor: Colors.blue[300],
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
          );
  }
}
