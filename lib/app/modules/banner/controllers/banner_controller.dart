import 'package:al_dana_admin/app/data/data.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  var isLoading = false.obs;
  var bannerResult = BannerResult().obs;
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

  getDetails() async {
    isLoading(true);
    await getBanners();
    isLoading(false);
  }

  getBanners() async {
    bannerResult.value = await BannerProvider().getBanneres();
    bannerResult.refresh();
  }
}
