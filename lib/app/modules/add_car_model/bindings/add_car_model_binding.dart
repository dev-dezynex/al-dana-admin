import 'package:get/get.dart';

import '../controllers/add_car_model_controller.dart';

class AddCarModelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCarModelController>(
      () => AddCarModelController(),
    );
  }
}
