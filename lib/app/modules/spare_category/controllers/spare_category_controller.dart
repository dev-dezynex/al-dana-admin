import 'package:get/get.dart';

import '../../../data/data.dart';

class SpareCategoryController extends GetxController {
  var isLoading = false.obs;
  var spareCategoryResult = SpareCategoryResult().obs;
  @override
  void onInit() {
    super.onInit();
    getDetails();
  }

  void getDetails() async {
    isLoading(true);
    await getSpareCategories();
    isLoading(false);
  }

  getSpareCategories() async {
    spareCategoryResult.value = await SpareCategoryProvider().listActiveSpareCategory();
    spareCategoryResult.refresh();
  }
}
