import 'package:get/get.dart';

import '../../../data/data.dart';

class VariantController extends GetxController {
  var isLoading = false.obs;
  var selectedModel = CarModel().obs;
  var carVariantResult = VariantResult().obs;
  @override
  void onInit() {
    super.onInit();
    selectedModel.value = Get.arguments;
    getDetails();
  }



  void getDetails() async {
    isLoading(true);
    await getCarVariants();
    isLoading(false);
  }

  getCarVariants() async {
    carVariantResult.value =
        await VariantProvider().getVariantList(selectedModel.value.sId!);
    carVariantResult.refresh();
  }
}
