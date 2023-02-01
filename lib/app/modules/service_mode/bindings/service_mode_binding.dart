import 'package:get/get.dart';

import '../controllers/service_mode_controller.dart';

class ServiceModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceModeController>(
      () => ServiceModeController(),
    );
  }
}
