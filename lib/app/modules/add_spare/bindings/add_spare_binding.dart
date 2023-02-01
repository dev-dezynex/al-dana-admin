import 'package:get/get.dart';

import '../controllers/add_spare_controller.dart';

class AddSpareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddSpareController>(
      () => AddSpareController(),
    );
  }
}
