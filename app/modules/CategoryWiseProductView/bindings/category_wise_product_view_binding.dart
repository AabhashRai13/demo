import 'package:get/get.dart';

import '../controllers/category_wise_product_view_controller.dart';

class CategoryWiseProductViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryWiseProductViewController>(
      () => CategoryWiseProductViewController(),
    );
  }
}
