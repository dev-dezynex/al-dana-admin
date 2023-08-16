import 'package:get/get.dart';

import '../../../data/data.dart';

class PackageListController extends GetxController {
  var isLoading = false.obs;
  var packageResult = PackageResult().obs;
  var isEdit = false.obs;
  @override
  void onInit() {
    super.onInit();
    getPackages();
  }

  void getPackages() async {
    isLoading(true);
    packageResult.value = await PackageProvider().getActivePackageList();
    packageResult.refresh();
    isLoading(false);
  }
}
