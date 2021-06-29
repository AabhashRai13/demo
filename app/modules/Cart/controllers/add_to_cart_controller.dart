import 'package:bees_pharmacy/base%20model/base_model.dart';
import 'package:bees_pharmacy/model/cart_model.dart';
import 'package:bees_pharmacy/utils/dataBase_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';

class AddToCartController extends BaseController {
  List<CartModel> cartModel = List<CartModel>.empty(growable: true).obs;
  var products = [].obs;
  var count = [].obs;
  var productAvailable = false.obs;
  var checkoutList = [].obs;

  @override
  void onInit() {
    super.onInit();


  }

  populateCartQuantityCart() {
    for (var i = 0; i < products.length; i++) {
      count.add(products[i].quantity);
      print("length of count   ${count.length}");
    }
  }



  void insert(String name, String productDetails, String imageUrl, double price,
      int productId, int variant,String  variantType, int quantity) async {
    int pk = await DataBaseHelper.instance.insert({
      DataBaseHelper.columnName: name,
      DataBaseHelper.columnImage: imageUrl,
      DataBaseHelper.columnPrice: price,
      DataBaseHelper.columnProductId: productId,
      DataBaseHelper.columnVariant: variant,
      DataBaseHelper.columnVariantType: variantType,
      DataBaseHelper.columnQuantity: quantity,
    });
    print("inserted pk is $pk");
    if (pk != null) {
      Fluttertoast.showToast(
          msg: "Product added to cart!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.blue[300],
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Error occured! Product could not be added to cart!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.blue[300],
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }




  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment(int index) {
    products[index].quantity =  products[index].quantity+1;
    count[index] = count[index] + 1;
    print("count ${count[index]}");
  }



  void decrement(int index) => count[index] = count[index] - 1;

}
