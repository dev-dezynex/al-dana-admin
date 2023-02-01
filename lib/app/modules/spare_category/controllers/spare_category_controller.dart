import 'package:get/get.dart';

import '../../../data/data.dart';

class SpareCategoryController extends GetxController {
  var spareCategoryResult = SpareCategoryResult().obs;
  @override
  void onInit() {
    super.onInit();
    getDetails();
  }



  void getDetails() {
    getSpareCategories();
  }

  void getSpareCategories() async {
    spareCategoryResult.value = await SpareCategoryProvider().getDummyData();
    spareCategoryResult.refresh();
  }
}
