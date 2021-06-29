import 'package:bees_pharmacy/app/modules/prescription_page/views/text_upload_view.dart';
import 'package:bees_pharmacy/app/routes/app_pages.dart';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/storage/sharedprefences/shared_preferences_manager.dart';
import 'package:bees_pharmacy/widgets/CartWidget/CartWidgets.dart';
import 'package:bees_pharmacy/widgets/widet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 18,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cart',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ),
        body: Obx(() => cartController.state == ViewState.Busy
            ? _buildLoadingWidget()
            : _buildSuccessWidget(context)),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return SpinKitCircle(color: Colors.blue[400]);
  }

  _buildSuccessWidget(context) {
    return cartController.products.length == 0
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.blue[400],
                  size: 36,
                ),
                gap(16, 0),
                Text(
                  'No items in the cart!',
                  style: TextStyle(
                      color: Colors.blue[400],
                      fontSize: 22,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Obx(() => ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: List.generate(cartController.products.length,
                          (index) {
                        return GetBuilder<CartController>(
                          // init: cartController,
                          builder: (controller) => cartContainer(
                              controller.products[index].title,
                              controller.products[index].price,
                              controller.products[index].image,
                              100,
                              100,
                              Get.width,
                              null,
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 16,
                              ),
                              index,
                              controller.products[index].id,
                              controller.products[index].variant,
                              controller.products[index].variantType,
                              controller.products[index].quantity,
                              controller,
                              controller.controllers[index]),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      height: 140,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 4,
                            spreadRadius: 2,
                            color: Colors.grey.withOpacity(0.3),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(color: Colors.blue),
                              ),
                              Text(
                                  "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}")
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(color: Colors.black),
                              ),
                              Obx(
                                () => Text(
                                  'Rs. ${cartController.total.value}',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              onPressed: () {
                                if (locator<SharedPreferencesManager>()
                                        .isKeyExists('isLogin') ==
                                    false) {
                                  showLoginDialog(context);
                                } else {
                                  cartController.checkout();
                                  Map value = {
                                    "controller": cartController,
                                    "productsMapList":
                                        cartController.checkoutList
                                  };
                                  Get.toNamed(Routes.CHECKOUT,
                                      arguments: value);
                                }
                              },
                              color: Colors.blue,
                              child: Text(
                                'Checkout',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          );
  }
}
