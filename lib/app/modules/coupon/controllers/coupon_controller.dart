import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

class CouponController extends GetxController {
  var isLoading = false.obs;
  var couponResult = CouponResult().obs;
  TextEditingController discountAmountController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 10));
  var couponTypeList = ['Special', 'Personal'].obs;
  var selectedCouponType = 'Special'.obs;
  var userResult = UserResult.list().obs;
  var selectedUser = User().obs;
  var selectedCoupon = Coupon();
  RxString discountAmount = ''.obs;
  @override
  void onInit() {
    super.onInit();
    getDetails();
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

  deletCoupon(String id) async {
    await CouponProvider().deleteCoupon(id: id);
    getDetails();
  }

  updateCoupon(String id) async {
    isLoading(true);
    var result = await CouponProvider().updateCoupon(
        coupon: selectedCoupon.copyWith(
          discountAmount: double.parse(discountAmountController.text),
          amount: double.parse(amountController.text),
          couponType: selectedCouponType.value,
          customerId: selectedCouponType.value == couponTypeList[1]
              ? Common().currentUser.id
              : '',
          startDate: startDate.toUtc().toString(),
          endDate: endDate.toUtc().toString(),
        ),
        id: id);
    if (result.status == 'success') {
      Get.back(result: true);
    } else {
      showError(result.message!);
      log(result.message!);
    }
    isLoading(false);
  }

  void setStartDate(DateTime value) {
    startDate = value;
    startDateController.text = outputDateFormat3.format(value);
  }

  void setEndDate(DateTime value) {
    endDate = value;
    endDateController.text = outputDateFormat3.format(value);
  }
}
