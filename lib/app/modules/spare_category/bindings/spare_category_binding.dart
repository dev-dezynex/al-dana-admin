import 'package:get/get.dart';

import '../controllers/spare_category_controller.dart';

class SpareCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpareCategoryController>(
      () => SpareCategoryController(),
    );
  }
}
