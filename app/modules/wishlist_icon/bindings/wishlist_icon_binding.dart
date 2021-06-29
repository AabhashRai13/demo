import 'package:get/get.dart';

import '../controllers/wishlist_icon_controller.dart';

class WishlistIconBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WishlistIconController>(
      () => WishlistIconController(),
    );
  }
}
