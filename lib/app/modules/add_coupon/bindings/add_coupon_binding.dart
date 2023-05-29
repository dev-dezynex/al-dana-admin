import 'package:get/get.dart';

import '../controllers/add_coupon_controller.dart';

class AddCouponBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCouponController>(
      () => AddCouponController(),
    );
  }
}
