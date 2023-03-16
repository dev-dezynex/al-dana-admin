import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

class AddVariantController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController engineCapacityController = TextEditingController();
  TextEditingController engineOilController = TextEditingController();
  TextEditingController gearOilController = TextEditingController();
  TextEditingController tyreController = TextEditingController();
  TextEditingController thumbController = TextEditingController();

  var bgCardColor = const Color(0xff443a49).obs;
  var isUpdate = false.obs;
  var isLoading = false.obs;
  var thumbFile = File('').obs;
  var selectedVariant = Variant().obs;
  var selectedModel = CarModel().obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments[0]) {
        isUpdate(true);
        selectedVariant.value = Get.arguments[1];
        setFields();
      } else {
        isUpdate(false);
        selectedModel.value = Get.arguments[1];
      }
    }
  }



  void setFields() {
    nameController.text = selectedVariant.value.title;
    descController.text = selectedVariant.value.desc;
    engineCapacityController.text =
        selectedVariant.value.engineCapacity.toString();
    engineOilController.text =
        selectedVariant.value.engineOilCapacity.toString();
    gearOilController.text = selectedVariant.value.gearOilCapacity.toString();
    tyreController.text = selectedVariant.value.tyreSize.toString();
    thumbController.text = selectedVariant.value.image.split('/').last;
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
    return selectedVariant.value.image;
  }

  void createVariant() async {
    String imagePath = await imageUpload();
    var result = await VariantProvider().addOrUpdateVariant(
        carVariant: Variant(
      id: isUpdate.value ? selectedVariant.value.id : '',
      carModelId: isUpdate.value
          ? selectedVariant.value.carModelId
          : selectedModel.value.sId!,
      title: nameController.text,
      desc: descController.text,
      engineCapacity: engineCapacityController.text.isNotEmpty
          ? double.parse(engineCapacityController.text)
          : 0.0,
      engineOilCapacity: engineOilController.text.isNotEmpty
          ? double.parse(engineOilController.text)
          : 0.0,
      gearOilCapacity: gearOilController.text.isNotEmpty
          ? double.parse(gearOilController.text)
          : 0.0,
      tyreSize: tyreController.text.isNotEmpty
          ? double.parse(tyreController.text)
          : 0.0,
      image: imagePath,
    ));
    if (result.status == 'success') {
      Get.back(result: true);
    } else {
      Get.snackbar('Error', result.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }
  }

  void deleteVariant() async {
    final result = await VariantProvider()
        .deleteVariant(carVariant: selectedVariant.value);
    if (result.status == 'success') {
      Get.back();
      Get.back(result: true);
    } else {
      Get.snackbar('Error', result.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }
  }
}
