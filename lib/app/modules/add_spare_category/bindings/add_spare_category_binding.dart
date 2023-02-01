import 'package:get/get.dart';

import '../controllers/add_spare_category_controller.dart';

class AddSpareCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddSpareCategoryController>(
      () => AddSpareCategoryController(),
    );
  }
}
