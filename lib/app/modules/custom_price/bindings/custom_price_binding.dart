import 'package:get/get.dart';

import '../controllers/custom_price_controller.dart';

class CustomPriceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomPriceController>(
      () => CustomPriceController(),
    );
  }
}
