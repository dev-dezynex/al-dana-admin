import 'package:al_dana_admin/app/data/data.dart';
import 'package:get/get.dart';

class ServiceModeController extends GetxController {
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
    serviceModeResult.value = await ServiceModeProvider().getDummyData();
    serviceModeResult.refresh();
  }
}
