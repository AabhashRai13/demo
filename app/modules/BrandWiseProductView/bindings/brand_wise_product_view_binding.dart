import 'package:get/get.dart';

import '../controllers/brand_wise_product_view_controller.dart';

class BrandWiseProductViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrandWiseProductViewController>(
      () => BrandWiseProductViewController(),
    );
  }
}
