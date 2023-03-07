import 'package:get/get.dart';

import '../../../data/data.dart';

class BranchListController extends GetxController {
  var isLoading = false.obs;
  var branchResult = BranchResult().obs;
  @override
  void onInit() {
    super.onInit();
    getDetails();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getDetails() {
    getBranches();
  }

  void getBranches() async {
    isLoading.value = true;
    branchResult.value = await BranchProvider().getBranches();
    branchResult.refresh();
    isLoading.value = false;
  }
}
