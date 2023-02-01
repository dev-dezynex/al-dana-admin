import 'package:get/get.dart';

import '../controllers/add_service_mode_controller.dart';

class AddServiceModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddServiceModeController>(
      () => AddServiceModeController(),
    );
  }
}
