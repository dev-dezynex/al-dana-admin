import 'package:get/get.dart';

import '../controllers/car_model_controller.dart';

class CarModelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarModelController>(
      () => CarModelController(),
    );
  }
}
