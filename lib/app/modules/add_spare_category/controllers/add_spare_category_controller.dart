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

  void createSpareCategory() async {
    isLoading(true);
    String imagePath = await imageUpload();
    var result = await SpareCategoryProvider().addSpareCategory(
        SpareCategory(name: nameController.text, image: imagePath));
    if (result.status == 'success') {
      Get.back(result: true);
    } else {
      Get.snackbar(
        'Error',
        result.message!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: textDark20,
      );
    }

    isLoading(false);
  }

  void updateSpareCategory() async {
    isLoading(true);
    String imagePath = await imageUpload();
    var result = await SpareCategoryProvider().updateSpareCategory(
        SpareCategory(
            id: selectedSpareCategory.value.id,
            name: nameController.text,
            image: imagePath));
    if (result.status == 'success') {
      Get.back(result: true);
    } else {
      Get.snackbar(
        'Error',
        result.message!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: textDark20,
      );
    }

    isLoading(false);
  }

  Future<String> imageUpload() async {
    if (thumbFile.value.path.isNotEmpty) {
      var result = await FileProvider().uploadSingleFile(file: thumbFile.value);
      if (result['status'] == 'success') {
        return result['data'][0];
      }
    }
    return selectedSpareCategory.value.image;
  }

  void deleteSpareCategory() async {
    isLoading(true);
    var result = await SpareCategoryProvider()
        .deleteSpareCategory(spareCategoryId: selectedSpareCategory.value.id);
    if (result.status == 'success') {
      Get.back();
      Get.back(result: true);
    } else {
      Get.snackbar(
        'Error',
        result.message!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: textDark20,
      );
    }

    isLoading(false);
  }

  void setFields() {
    nameController.text = selectedSpareCategory.value.name;
    thumbController.text = selectedSpareCategory.value.image.split('/').last;
  }
}
