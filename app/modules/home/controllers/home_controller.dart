import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/utils/wishlist_service_api.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:bees_pharmacy/api/api_auth_provider.dart';

class HomeController extends GetxController {
  WishListServiceApi wishListServiceApi = locator<WishListServiceApi>();
  ApiAuthProvider apiAuthProvider = ApiAuthProvider();
  var appbarTitle = 'Home'.obs;
  bool added = false;

  var homeIcon = Icon(Icons.search_outlined).obs;

  final currentIndex = 0.obs;
  final colorOne = Colors.red[800].obs;
  final colorTwo = Colors.grey.shade400.obs;

  var productAvailable = false.obs;

  setBottomBarIndex(index, name,Icon icon) {
    print(index);
    currentIndex.value = index;
    appbarTitle.value = name;
    homeIcon.value = icon;
    update();
  }



  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    wishListServiceApi.fetchWishList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
