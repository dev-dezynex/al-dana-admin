import 'dart:io';

import 'package:al_dana_admin/app/data/data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddBrandController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  // TextEditingController varientController = TextEditingController();
  TextEditingController thumbController = TextEditingController();

  var bgCardColor = const Color(0xff443a49).obs;
  var isUpdate = false.obs;
  var isLoading = false.obs;
  var thumbFile = File('').obs;
  var selectedBrand = Brand().obs;
  // var varientList = <Variant>[].obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      isUpdate(true);
      selectedBrand.value = Get.arguments;
      setFields();
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
    nameController.text = selectedBrand.value.name;
    descController.text = selectedBrand.value.desc;
    // varientList.value = selectedBrand.value.variantList!;
    thumbController.text = selectedBrand.value.image.split('/').last;
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
    return selectedBrand.value.image;
  }

  void createBrand() async {
    String imagePath = await imageUpload();
    var result = await BrandProvider().addOrUpdateBrand(
        brand: Brand(
      id: isUpdate.value ? selectedBrand.value.id : '',
      name: nameController.text,
      desc: descController.text,
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

  void deleteBrand() async {
    final result =
        await BrandProvider().deleteBrand(brand: selectedBrand.value);
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

  // void addVarient() {
  //   bool isContain = false;

  //   for (Variant variant in varientList) {
  //     if (variant.name == varientController.text) {
  //       isContain = true;
  //     }
  //   }

  //   if (!isContain) {
  //     //need to call the varient adding APi and refresh the list
  //     varientList.add(Variant(id: '45', name: varientController.text));
  //     varientController.text = '';
  //   }
  // }

  // void deleteVarient(Variant varient) {
  //   //Need to call the varient delete API and refresh the list
  //   varientList.remove(varient);
  //   varientList.refresh();
  //   Get.back();
  // }
}
