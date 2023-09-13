import 'package:get/get.dart';

import '../controllers/extra_charge_controller.dart';

class ExtraChargeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExtraChargeController>(
      () => ExtraChargeController(),
    );
  }
}
