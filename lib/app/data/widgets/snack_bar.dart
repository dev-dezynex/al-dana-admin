import 'package:get/get.dart';

import '../data.dart';

showError(String message) {
  Get.snackbar('Error', message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: textDark20,
      colorText: textDark80);
}
showSuccess(String message) {
  Get.snackbar('Success', message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: textDark20,
      colorText: textDark80);
}
