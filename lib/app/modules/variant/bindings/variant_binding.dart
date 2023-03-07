import 'package:get/get.dart';

import '../controllers/variant_controller.dart';

class VariantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VariantController>(
      () => VariantController(),
    );
  }
}
