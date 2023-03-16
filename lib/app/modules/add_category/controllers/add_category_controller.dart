import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

class AddCategoryController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  // TextEditingController serviceModeController = TextEditingController();
  TextEditingController thumbController = TextEditingController();

  var bgCardColor = const Color(0xff443a49).obs;
  var isUpdate = false.obs;
  var isLoading = false.obs;
  var thumbFile = File('').obs;


  var selectedCategory = Category().obs;
  @override
  void onInit() {
    super.onInit();
    getDetails();
  }

  Future<String> imageUpload() async {
    if (thumbFile.value.path.isNotEmpty) {
      var result = await FileProvider().uploadSingleFile(file: thumbFile.value);
      if (result['status'] == 'success') {
        return result['data'][0];
      }
    }
    return selectedCategory.value.image;
  }

  void createCategory() async {
    isLoading(true);
    String imagePath = await imageUpload();
    var result = await CategoryProvider().addOrUpdateCategory(
        category: Category(
      title: titleController.text,
      desc: descController.text,
      bgCardColor: colorToHexValue(bgCardColor.value),
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
    isLoading(false);
  }

  void updateCategory() async {
    isLoading(true);
    String imagePath = await imageUpload();
    var result = await CategoryProvider().addOrUpdateCategory(
        category: Category(
            id: selectedCategory.value.id,
            title: titleController.text,
            desc: descController.text,
            bgCardColor: colorToHexValue(bgCardColor.value),
            image: imagePath));
    if (result.status == 'success') {
      Get.back(result: true);
    } else {
      Get.snackbar('Error', result.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }
    isLoading(false);
  }

  void deleteCategory() async {
    final result = await CategoryProvider()
        .deleteCategory(category: selectedCategory.value);
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

  pickThumb() async {
    thumbFile.value = (await FileProvider().pickFile(
        fileType: FileType.custom, allowedExtensions: ['png', 'jpeg']))!;
    String fileName = thumbFile.value.path.split('/').last;
    print('file url path ${thumbFile.value.path}');
    print('file picked path $fileName');

    thumbController.text = fileName;
  }

  void getDetails() async {

    if (Get.arguments != null) {
      isUpdate.value = true;
      selectedCategory.value = Get.arguments;
      setFields();
    }
  }



  void setFields() {
    titleController.text = selectedCategory.value.title;
    descController.text = selectedCategory.value.desc;
    // for (ServiceMode mode in selectedCategory.value.modeList) {
    //   if (modeList.firstWhereOrNull((element) => element.id == mode.id) !=
    //       null) {
    //     print("contains");
    //     selectedModeList.add(mode);
    //   } else {
    //     print("not contains");
    //   }
    // }
    // serviceModeController.text =
    //     selectedModeList.map((element) => element.title).join(', ');
    thumbController.text = selectedCategory.value.image.split('/').last;
    bgCardColor.value = hexToColor(selectedCategory.value.bgCardColor);
  }
}
