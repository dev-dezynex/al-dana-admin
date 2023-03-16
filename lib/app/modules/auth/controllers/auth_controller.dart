import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  String contryCode = '971';
  TextEditingController usernameController =
      TextEditingController(text: 'superAdmin');
  TextEditingController passwordController =
      TextEditingController(text: 'superAdmin123');

  @override
  void onClose() {}

  void verifyUser() async {
    isLoading.value = true;
    UserResult result;
    result = await UserProvider().signIn(
        username: usernameController.text, password: passwordController.text);
    print('result ${jsonEncode(result)}');
    if (result.status == 'success') {
      
      result = await UserProvider().getProfile();
      if (result.status == 'success') {
        storage.write(is_login, true);
        storage.write(user_details, result.user.toJson());
        Get.offAllNamed(Routes.HOME);
        print('in success condition');
        return;
      }
    }
    print('in error condition');
    Get.snackbar('Error', result.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: textDark20,
        colorText: textDark80);

    isLoading.value = false;
  }
}
