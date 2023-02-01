import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';


class AddSpareController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController thumbController = TextEditingController();

  var thumbFile = File('').obs;
  var isUpdate = false.obs;
  var isLoading = false.obs;
  var selectedSpare = Spare().obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      isUpdate.value = true;
      selectedSpare.value = Get.arguments;
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

  void setFields() {
    nameController.text = selectedSpare.value.name!;
    qtyController.text = selectedSpare.value.qty.toString();
    priceController.text = selectedSpare.value.price.toString();
    thumbController.text = selectedSpare.value.image!.split('/').last;
  }

  void createSpare() {}

  void deleteSpare() {}
}
