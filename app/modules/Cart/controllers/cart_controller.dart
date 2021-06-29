import 'package:bees_pharmacy/base%20model/base_model.dart';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/model/cart_model.dart';
import 'package:bees_pharmacy/utils/dataBase_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';

class CartController extends BaseController {
  List<CartModel> cartModel = List<CartModel>.empty(growable: true).obs;
  var products = [].obs; 
  var productAvailable = false.obs;
  var checkoutList = [].obs;
  var totalPrice = [].obs; 
  var total = 0.obs;
  var count = List<int>().obs;
  List<TextEditingController> controllers = [];

  @override
  void onInit() {
    super.onInit();
    getCart();
    Future.delayed(const Duration(milliseconds: 10), () {
      checkoutList();
    });
  }

  void getCart() async {
    setState(ViewState.Busy);
    cartModel = await DataBaseHelper.instance.getCart();
    products.addAll(cartModel);
    populateController();
    populateCount();
    // setState(ViewState.Retrieved);
    productAvailable.value = cartModel != null;
    setState(ViewState.Retrieved);
    populatePriceTotalList();
    // priceCharge();
    totalCharge();
    displayAll();
  }

  void insert(String name, String productDetails, String imageUrl, double price,
      int productId, int variant, int quantity) async {
    int pk = await DataBaseHelper.instance.insert({
      DataBaseHelper.columnName: name,
      DataBaseHelper.columnImage: imageUrl,
      DataBaseHelper.columnPrice: price,
      DataBaseHelper.columnProductId: productId,
      DataBaseHelper.columnVariant: variant,
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

  deleteProducts(int productId, int index, int variantId) async {
    int delete =
        await DataBaseHelper.instance.delete(productId, variantId ?? null);
    print("id $productId");
    print("delete $delete");
    if (delete == 1) {
      products.removeWhere((item) => item.productId == productId);
      total = total - totalPrice[index].round();
      count.removeAt(index);
      totalPrice.removeAt(index);
    } else if (delete == 2) {
      products.removeWhere((item) => item.variant == variantId);
      total = total - totalPrice[index].round();
      count.removeAt(index);
      totalPrice.removeAt(index);
    }
    displayAll();
  }

  void displayAll() async {
    List<Map<String, dynamic>> queryRows =
        await DataBaseHelper.instance.queryAll();
    print(queryRows);
    update();
  }

  populatePriceTotalList() {
    print("yo challa ta khai?");
    for (var i = 0; i < products.length; i++) {
      totalPrice.add(products[i].quantity * products[i].price.round());
      print("length of delivery   ${totalPrice.length}");
    }
  }

  populateCount() {
    for (var i = 0; i < products.length; i++) {
      count.add(products[i].quantity.round());
    }
  }

  void checkout() {
    for (int i = 0; i < products.length; i++) {
      checkoutList.add({
        "product_id": products[i].productId,
        "quantity": count[i],
        "variant_id": products[i].variant ?? 1
      });
    }
    print("check out list $checkoutList");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  populateController() {
    for (var i = 0; i < products.length; i++) {
      controllers.add(TextEditingController());
    }
  }

  void increment(int index) {
    count[index] = count[index] + 1;
    total = total + products[index].price.round();
    update();
    print(count[index]);
  }

  void decrement(int index) {
    count[index] = count[index] - 1;
    total = total - products[index].price.round();

    update();
    print(count[index]);
  }

  totalCharge() {
    for (var i = 0; i < products.length; i++) {
      total = total + totalPrice[i].round();
    }
  }



  

  updatePrice() {
    total.value = 0;
    for (var i = 0; i < products.length; i++) {
      total = total + totalPrice[i].round();
      update();
    }
  }
}
