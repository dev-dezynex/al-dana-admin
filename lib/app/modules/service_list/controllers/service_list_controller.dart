import 'package:get/get.dart';

import '../../../data/data.dart';

class ServiceListController extends GetxController {
  var isLoading = false.obs;
  var serviceResult = ServiceResult().obs;
  @override
  void onInit() {
    super.onInit();
    getServices();
  }



  getServices() async {
    serviceResult.value = await ServiceProvider().getDummyData();
    serviceResult.refresh();
  }
}
