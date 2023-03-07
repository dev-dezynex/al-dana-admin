import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

class AddPackageController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController thumbController = TextEditingController();

  var bgCardColor = const Color(0xff443a49).obs;
  var isUpdate = false.obs;
  var isLoading = false.obs;
  var thumbFile = File('').obs;

  var serviceResult = ServiceResult().obs;
  var selectedServices = <Service>[].obs;
  var selectedPackage = PackageModel().obs;

  @override
  void onInit() {
    super.onInit();
    getDetails();
  }

  getDetails() async {
    await getServices();
    if (Get.arguments != null) {
      isUpdate(true);
      selectedPackage.value = Get.arguments;
      setFields();
    }
  }

  void setFields() {
    titleController.text = selectedPackage.value.title!;
    thumbController.text = selectedPackage.value.image!.split('/').last;
    priceController.text = selectedPackage.value.price.toString();
    bgCardColor.value = hexToColor(selectedPackage.value.bgCardColor!);
    selectedServices.value = selectedPackage.value.services!;
  }

  getServices() async {
    serviceResult.value = await ServiceProvider().getServices();
    serviceResult.refresh();
  }

  pickThumb() async {
    thumbFile.value = (await FileProvider().pickFile(
        fileType: FileType.custom, allowedExtensions: ['png', 'jpeg']))!;
    String fileName = thumbFile.value.path.split('/').last;
    print('file url path ${thumbFile.value.path}');
    print('file picked path $fileName');

    thumbController.text = fileName;
  }

  void createPackage() {}

  void deletePackage() {}
}
