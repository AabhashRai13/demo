import 'package:bees_pharmacy/api/product_api.dart';
import 'package:bees_pharmacy/base%20model/base_model.dart';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/model/product_model.dart';
import 'package:bees_pharmacy/storage/sharedprefences/shared_preferences_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DetailPage2Controller extends BaseController {
  final count = 1.obs;

  List photos = [].obs;
  String name = Get.arguments.name;
  double price = Get.arguments.variant[0].price;
  double oldPrice = Get.arguments.variant[0].oldPrice;
  String description = Get.arguments.description;
  double discountPercentage = Get.arguments.discountPercent;
  String brand =
      Get.arguments.brand == null ? "N/A" : Get.arguments.brand.name.toString();
  bool isOnSale = Get.arguments.isOnSale;
  List variant = [].obs;
  String paraPhoto =
      Get.arguments.photos.length == 0 ? null : Get.arguments.photos[0].photo;

  final TextEditingController countController = TextEditingController();
  int id = Get.arguments.id;
  bool tokenNeeded = false;
  Products similarProducts;
  var productAvailable = false.obs;
  List productResponse = [].obs;
  ProductApiProvider productApiProvider = ProductApiProvider();
  @override
  void onInit() {
    checkIfOnline();
    super.onInit();
    checkphoto();
    variant.addAll(Get.arguments.variant);
    enterPhoto();
    print("variant $variant");
    Future.delayed(Duration(seconds: 1), () {
      fetSimilarProducts(id);
    });
  }

  void checkIfOnline() {
    if (locator<SharedPreferencesManager>().isKeyExists('isLogin') == true) {
      tokenNeeded = true;
    } else {
      tokenNeeded = false;
    }
  }

  void checkphoto() {
    if (Get.arguments.photos.length <= 0 || Get.arguments.photos == null) {
      photos = null;
    } else {
      photos.assignAll(Get.arguments.photos);
    }
  }

  void enterPhoto() {
    if (Get.arguments.photos.length <= 0 || Get.arguments.photos == null) {
      photos = null;
      print("okkkkk");
    } else {
      photos.assignAll(Get.arguments.photos);
      print("Photos ${photos[0].photo}");
    }
  }

  void fetSimilarProducts(int similarId) async {
    similarProducts =
        await productApiProvider.getSimilarProducts(similarId, tokenNeeded);
    print('result ho hai: ${similarProducts.results}');
    productResponse.assignAll(similarProducts.results);
    productAvailable.value = similarProducts != null;
    print('similar products ${productResponse.length}');
    setState(ViewState.Retrieved);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;

  void decrement() => count.value--;
}
