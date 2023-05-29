import 'package:get/get.dart';

import '../../../data/data.dart';

class CouponController extends GetxController {
  var isLoading = false.obs;
  var couponResult = CouponResult().obs;
  @override
  void onInit() {
    super.onInit();
    getDetails();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getDetails() async {
    isLoading(true);
    await getCoupons();
    isLoading(false);
  }

  getCoupons() async {
    couponResult.value = await CouponProvider().getCoupons();
    couponResult.refresh();
  }
}
