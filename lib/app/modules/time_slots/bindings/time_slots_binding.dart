import 'package:get/get.dart';

import '../controllers/time_slots_controller.dart';

class TimeSlotsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimeSlotsController>(
      () => TimeSlotsController(),
    );
  }
}
