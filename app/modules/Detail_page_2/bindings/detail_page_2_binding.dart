import 'package:get/get.dart';

import '../controllers/detail_page_2_controller.dart';

class DetailPage2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPage2Controller>(
      () => DetailPage2Controller(),
    );
  }
}
