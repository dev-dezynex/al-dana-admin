import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

class AddSpareController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController thumbController = TextEditingController();

  var branchResult = BranchResult().obs;
  var thumbFile = File('').obs;
  var isUpdate = false.obs;
  var isLoading = false.obs;
  var selectedSpare = Spare().obs;
  var selectedBranch = Branch().obs;
  var selectedSpareCategory = SpareCategory();
  @override
  void onInit() {
    super.onInit();
    getDetails();
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
    nameController.text = selectedSpare.value.name;
    descController.text = selectedSpare.value.desc;
    qtyController.text = selectedSpare.value.qty.toString();
    priceController.text = selectedSpare.value.price.toString();
    thumbController.text = selectedSpare.value.image.split('/').last;
    selectedBranch.value = branchResult.value.branchList!
        .firstWhere((element) => element.id == selectedSpare.value.branchId);
    branchController.text = selectedBranch.value.name;
  }

  void createSpare() async {
    isLoading(true);
    var result = await SpareProvider().addSpare(
        spare: Spare(
      branchId: selectedBranch.value.id,
      categoryId: selectedSpareCategory.id,
      name: nameController.text,
      desc: descController.text,
      price: priceController.text.isNotEmpty
          ? double.parse(priceController.text)
          : 0.0,
      qty: qtyController.text.isNotEmpty ? int.parse(qtyController.text) : 0,
      image: thumbController.text,
    ));
    if (result.status == 'success') {
      Get.back(result: true);
    } else {
      Get.snackbar('Error', result.message!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }

    isLoading(false);
  }

  void updateSpare() async {
    isLoading(true);
    var result = await SpareProvider().updateSpare(
        spare: Spare(
      id: selectedSpare.value.id,
      branchId: selectedBranch.value.id,
      categoryId: selectedSpare.value.categoryId,
      name: nameController.text,
      desc: descController.text,
      price: priceController.text.isNotEmpty
          ? double.parse(priceController.text)
          : 0.0,
      qty: qtyController.text.isNotEmpty ? int.parse(qtyController.text) : 0,
      image: thumbController.text,
    ));
    if (result.status == 'success') {
      Get.back(result: true);
    } else {
      Get.snackbar('Error', result.message!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }

    isLoading(false);
  }

  void deleteSpare() async {
    isLoading(true);
    var result =
        await SpareProvider().deleteSpare(spareId: selectedSpare.value.id);
    if (result.status == 'success') {
      Get.back();
      Get.back(result: true);
    } else {
      Get.snackbar('Error', result.message!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }

    isLoading(false);
  }

  void getDetails() async {
    isLoading(true);
    await getBranches();
    if (Get.arguments != null) {
      if (Get.arguments[0]) {
        isUpdate.value = true;
        selectedSpare.value = Get.arguments[1];
        setFields();
      } else {
        isUpdate.value = false;
        selectedSpareCategory = Get.arguments[1];
      }
    }
    isLoading(false);
  }

  getBranches() async {
    branchResult.value = await BranchProvider().getBranches();
    branchResult.refresh();
  }
}
