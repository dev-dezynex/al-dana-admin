import 'package:get/get.dart';

import '../../../data/data.dart';

class SpareController extends GetxController {
  var selectedSpareCategory = SpareCategory().obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      selectedSpareCategory.value = Get.arguments;
    }
  }


}
