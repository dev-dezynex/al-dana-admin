import 'package:al_dana_admin/app/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddServiceModeController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  var bgCardColor = const Color(0xff443a49).obs;
  var isUpdate = false.obs;
  var isLoading = false.obs;
  var selectedServiceMode = ServiceMode().obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      isUpdate(true);
      selectedServiceMode.value = Get.arguments;
      setFields();
    }
  }



  void setFields() {
    titleController.text = selectedServiceMode.value.title!;
    descController.text = selectedServiceMode.value.desc!;
    bgCardColor.value = hexToColor(selectedServiceMode.value.bgCardColor!);
  }

  void createMode() {}

  void deleteMode() {}
}
