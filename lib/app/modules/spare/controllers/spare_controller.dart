import 'package:get/get.dart';

import '../../../data/data.dart';

class SpareController extends GetxController {
  var isLoading = false.obs;
  var selectedSpareCategory = SpareCategory().obs;
  var spareResult = SpareResult().obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      selectedSpareCategory.value = Get.arguments;
      getSpares();
    }
  }

  void getSpares() async {
    isLoading(true);
    spareResult.value = await SpareProvider()
        .listActiveSpare(spareCategoryId: selectedSpareCategory.value.id);
    spareResult.refresh();
    isLoading(false);
  }
}
