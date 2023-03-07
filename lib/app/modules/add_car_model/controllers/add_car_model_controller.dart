import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

class AddCarModelController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController thumbController = TextEditingController();

  var bgCardColor = const Color(0xff443a49).obs;
  var isUpdate = false.obs;
  var isLoading = false.obs;
  var thumbFile = File('').obs;
  var selectedModel = CarModel().obs;
  var selectedBrand = Brand().obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments[0]) {
        isUpdate(true);
        selectedModel.value = Get.arguments[1];
        setFields();
      } else {
        isUpdate(false);
        selectedBrand.value = Get.arguments[1];
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setFields() {
    nameController.text = selectedModel.value.title!;
    descController.text = selectedModel.value.description!;
    thumbController.text = selectedModel.value.image!.split('/').last;
  }

  pickThumb() async {
    thumbFile.value = (await FileProvider().pickFile(
        fileType: FileType.custom, allowedExtensions: ['png', 'jpeg']))!;
    String fileName = thumbFile.value.path.split('/').last;
    print('file url path ${thumbFile.value.path}');
    print('file picked path $fileName');

    thumbController.text = fileName;
  }

  Future<String> imageUpload() async {
    if (thumbFile.value.path.isNotEmpty) {
      var result = await FileProvider().uploadSingleFile(file: thumbFile.value);
      if (result['status'] == 'success') {
        return result['data'][0];
      }
    }
    return selectedModel.value.image!;
  }

  void createBrand() async {
    String imagePath = await imageUpload();
    var result = await CarModelProvider().addOrUpdateCarModel(
        carModel: CarModel(
      sId: isUpdate.value ? selectedModel.value.sId! : '',
      title: nameController.text,
      description: descController.text,
      brandId:
          isUpdate.value ? selectedModel.value.brandId : selectedBrand.value.id,
      image: imagePath,
    ));
    if (result.status == 'success') {
      Get.back(result: true);
    } else {
      Get.snackbar('Error', result.message!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }
  }

  void deleteBrand() async {
    final result =
        await CarModelProvider().deleteCarModel(carModel: selectedModel.value);
    if (result.status == 'success') {
      Get.back();
      Get.back(result: true);
    } else {
      Get.snackbar('Error', result.message!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }
  }
}
