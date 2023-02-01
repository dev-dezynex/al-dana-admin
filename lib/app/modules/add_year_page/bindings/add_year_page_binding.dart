import 'package:get/get.dart';

import '../controllers/add_year_page_controller.dart';

class AddYearPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddYearPageController>(
      () => AddYearPageController(),
    );
  }
}
