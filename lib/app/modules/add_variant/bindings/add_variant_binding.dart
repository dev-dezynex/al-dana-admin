import 'package:get/get.dart';

import '../controllers/add_variant_controller.dart';

class AddVariantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddVariantController>(
      () => AddVariantController(),
    );
  }
}
