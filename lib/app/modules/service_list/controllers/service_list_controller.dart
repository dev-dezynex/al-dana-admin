import 'package:get/get.dart';

import '../../../data/data.dart';

class ServiceListController extends GetxController {
  var isLoading = false.obs;
  var serviceResult = ServiceResult().obs;
  var selectedCategory = Category().obs;
  @override
  void onInit() {
    super.onInit();
    getServices();
    // selectedCategory.value = Get.arguments;
  }

  getServices() async {
    serviceResult.value = await ServiceProvider().getServices();
    serviceResult.refresh();
  }
}
