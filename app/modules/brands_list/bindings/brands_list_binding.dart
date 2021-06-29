import 'package:get/get.dart';

import '../controllers/brands_list_controller.dart';

class BrandsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrandsListController>(
      () => BrandsListController(),
    );
  }
}
