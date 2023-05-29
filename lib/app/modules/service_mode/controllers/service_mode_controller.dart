import 'package:al_dana_admin/app/data/data.dart';
import 'package:get/get.dart';

class ServiceModeController extends GetxController {
  var isLoading = false.obs;
  var serviceModeResult = ServiceModeResult().obs;
  @override
  void onInit() {
    super.onInit();
    getDetails();
  }

  void getDetails() {
    getServiceModes();
  }

  void getServiceModes() async {
    isLoading(true);
    serviceModeResult.value = await ServiceModeProvider().getModes();
    serviceModeResult.refresh();
    isLoading(false);
  }
}
