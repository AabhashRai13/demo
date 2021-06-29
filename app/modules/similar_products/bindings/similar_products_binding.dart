import 'package:get/get.dart';

import '../controllers/similar_products_controller.dart';

class SimilarProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SimilarProductsController>(
      () => SimilarProductsController(),
    );
  }
}
