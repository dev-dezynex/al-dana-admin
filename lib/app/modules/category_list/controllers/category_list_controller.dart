import 'package:get/get.dart';

import '../../../data/data.dart';

class CategoryListController extends GetxController {
  var isLoading = false.obs;
  var categoryResult = CategoryResult().obs;
  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  void getCategories() async {
    isLoading(true);
    categoryResult.value = await CategoryProvider().getCategories();
    categoryResult.refresh();
    isLoading(false);
  }
}
