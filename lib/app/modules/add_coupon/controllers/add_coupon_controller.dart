import 'dart:developer';

import 'package:al_dana_admin/app/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddCouponController extends GetxController {
  var isLoading = false.obs;
  var isUpdate = false.obs;
  TextEditingController userController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 10));

  var couponTypeList = ['Special', 'Personal'].obs;
  var selectedCouponType = 'Special';
  var userResult = UserResult.list().obs;
  var selectedUser = User().obs;
  var selectedCoupon = Coupon();
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
    await getUsers();
    setStartDate(DateTime.now());
    setEndDate(DateTime.now().add(const Duration(days: 10)));
    isLoading(false);
  }

  getUsers() async {
    userResult.value = await UserProvider().getActiveCustomers();
    userResult.refresh();
  }

  void createCoupon() async {
    isLoading(true);
    var result = await CouponProvider().postCoupons(
        coupon: selectedCoupon.copyWith(
      title: titleController.text,
      customerId: selectedCouponType == couponTypeList[1]
          ? Common().currentUser.id
          : '',
      amount: double.parse(priceController.text),
      discountAmount: double.parse(discountController.text),
      startDate: startDate.toUtc().toString(),
      endDate: endDate.toUtc().toString(),
    ));

    if (result.status == 'success') {
      Get.back(result: true);
    } else {
      showError(result.message!);
      log(result.message!);
    }
    isLoading(false);
  }

  void deleteCoupon() {}

  void editCoupon() {}

  void setStartDate(DateTime value) {
    startDate = value;
    startDateController.text = outputDateFormat3.format(value);
  }

  void setEndDate(DateTime value) {
    endDate = value;
    endDateController.text = outputDateFormat3.format(value);
  }
}
