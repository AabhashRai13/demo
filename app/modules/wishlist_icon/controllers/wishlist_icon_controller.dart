import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/utils/wishlist_service_api.dart';
import 'package:get/get.dart';

class WishlistIconController extends GetxController {
  WishListServiceApi wishListService = locator<WishListServiceApi>();
  int productId;

  @override
  void onInit() {
    super.onInit();
  }

  deleteWishListItem(int id, String category) async {
     await wishListService.deleteWishListItem(id, category);
  }

  addToWishList(int id, String category, products) async {
     await wishListService.addToWishList(id, category, products);
  }



}
