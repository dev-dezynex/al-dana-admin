import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

class AddSpareCategoryController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController thumbController = TextEditingController();

  var thumbFile = File('').obs;
  var isUpdate = false.obs;
  var isLoading = false.obs;
  var selectedSpareCategory = SpareCategory().obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      isUpdate.value = true;
      selectedSpareCategory.value = Get.arguments;
      setFields();
    }
  }



  pickThumb() async {
    thumbFile.value = (await FileProvider().pickFile(
        fileType: FileType.custom, allowedExtensions: ['png', 'jpeg']))!;
    String fileName = thumbFile.value.path.split('/').last;
    print('file url path ${thumbFile.value.path}');
    print('file picked path $fileName');

    thumbController.text = fileName;
  }

  void createSpareCategory() {}

  void deleteSpareCategory() {}

  void setFields() {
    nameController.text = selectedSpareCategory.value.name;
    thumbController.text = selectedSpareCategory.value.image.split('/').last;
  }
}
