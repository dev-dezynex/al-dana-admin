import 'package:get/get.dart';

import '../controllers/add_color_page_controller.dart';

class AddColorPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddColorPageController>(
      () => AddColorPageController(),
    );
  }
}
