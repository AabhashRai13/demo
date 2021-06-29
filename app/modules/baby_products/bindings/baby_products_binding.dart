import 'package:get/get.dart';

import '../controllers/baby_products_controller.dart';

class BabyProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BabyProductsController>(
      () => BabyProductsController(),
    );
  }
}
