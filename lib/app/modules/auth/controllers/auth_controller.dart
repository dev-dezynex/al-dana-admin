import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  String contryCode = '971';
  TextEditingController usernameController =
      TextEditingController(text: 'amal@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: 'amal@123');

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}

  void verifyUser() async {
    isLoading.value = true;
    UserResult result = await UserProvider().verifyUser(
        username: usernameController.text, password: passwordController.text);

    if (result.status == 'success') {
      storage.write(is_login, true);
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar('Error', result.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }

    isLoading.value = false;
  }
}
