import 'package:bees_pharmacy/app/modules/bees_wishlist/views/wishlist_view.dart';

import 'package:bees_pharmacy/app/modules/drawer/views/drawer_view.dart';
import 'package:bees_pharmacy/app/modules/home/controllers/home_controller.dart';
import 'package:bees_pharmacy/app/modules/home/views/login_register_view.dart';
import 'package:bees_pharmacy/app/modules/productPage/allProductPage.dart';
import 'package:bees_pharmacy/app/modules/search_page/views/search_page_view.dart';
import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/storage/sharedprefences/shared_preferences_manager.dart';
import 'package:bees_pharmacy/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  final HomeController homeController = Get.put(HomeController());

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
        bottomNavigationBar: BottomNavBar(),
        drawer: DrawerView(),
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                  homeController.appbarTitle.value,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Get.to(() => SearchView());
                  },
                  icon: Icon(Icons.search_outlined))
            ],
          ),
        ),
        body: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (data) {
              switch (data.currentIndex.value) {
                case 3:
                  return Container(
                    color: Colors.blue[400],
                  );
                case 2:
                  return SearchView();
                case 1:
                  return locator<SharedPreferencesManager>()
                              .isKeyExists('isLogin') ==
                          false
                      ? (LoginRegisterView())
                      : WishListView();
                default:
                  return AllProductListView();
              }
            }),
      ),
    );
  }
}
