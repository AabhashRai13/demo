import 'package:get/get.dart';

import '../controllers/prescription_page_controller.dart';

class PrescriptionPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrescriptionPageController>(
      () => PrescriptionPageController(),
    );
  }
}
