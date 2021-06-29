import 'package:get/get.dart';

import '../controllers/khalti_payment_controller.dart';

class KhaltiPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KhaltiPaymentController>(
      () => KhaltiPaymentController(),
    );
  }
}
