import 'package:get/get.dart';

import '../controllers/spare_controller.dart';

class SpareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpareController>(
      () => SpareController(),
    );
  }
}
