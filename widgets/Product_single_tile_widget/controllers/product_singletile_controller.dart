import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/utils/wishlist_service_api.dart';
import 'package:get/get.dart';

class ProductSingleTileController extends GetxController {
  final products;
  final category;

  ProductSingleTileController({this.products, this.category});

  WishListServiceApi wishListServiceApi = locator<WishListServiceApi>();
  var isAdded = false;




  var controller;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

 
}
