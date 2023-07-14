import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

class AddBranchController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController thumbController = TextEditingController();
  TextEditingController telNoController = TextEditingController();
  TextEditingController mobNoController = TextEditingController();
  TextEditingController postOfficeController = TextEditingController();
  TextEditingController taxRegNoController = TextEditingController();
  var bgCardColor = const Color(0xff443a49).obs;
  var isUpdate = false.obs;
  var isLoading = false.obs;
  var thumbFile = File('').obs;

  var selectedBranch = Branch().obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      isUpdate.value = true;
      selectedBranch.value = Get.arguments;
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

  Future<String> imageUpload() async {
    if (thumbFile.value.path.isNotEmpty) {
      var result = await FileProvider().uploadSingleFile(file: thumbFile.value);
      if (result['status'] == 'success') {
        return result['data'][0];
      }
    }
    return selectedBranch.value.image;
  }

  void createBranch() async {
    String imagePath = await imageUpload();
    var result = await BranchProvider().addOrUpdateBranch(
        branch: selectedBranch.value.copyWith(
      name: nameController.text,
      image: imagePath,
      telPhoneNo: telNoController.text,
      mobNo: mobNoController.text,
      postOfficeNo: postOfficeController.text,
      taxRegistrationNo: taxRegNoController.text,
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

  void updateBranch() async {
    String imagePath = await imageUpload();
    var result = await BranchProvider().addOrUpdateBranch(
        branch: selectedBranch.value.copyWith(
      name: nameController.text,
      image: imagePath,
      telPhoneNo: telNoController.text,
      mobNo: mobNoController.text,
      postOfficeNo: postOfficeController.text,
      taxRegistrationNo: taxRegNoController.text,
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

  void deleteBranch() async {
    final result =
        await BranchProvider().deleteBranch(branch: selectedBranch.value);
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

  void setFields() {
    nameController.text = selectedBranch.value.name;
    locationController.text = selectedBranch.value.location;
    mobNoController.text = selectedBranch.value.mobNo;
    telNoController.text = selectedBranch.value.telPhoneNo;
    postOfficeController.text = selectedBranch.value.postOfficeNo;
    taxRegNoController.text = selectedBranch.value.taxRegistrationNo;
    thumbController.text = selectedBranch.value.image.split('/').last;
  }

  attachAddress(Address address) {
    print("Address added ${jsonEncode(address)}");
    locationController.text = address.location;
    selectedBranch.value = selectedBranch.value.copyWith(
      location: address.location,
      landmark: address.landmark,
      latitude: address.latitude,
      longitude: address.longitude,
      addressType: address.addressType,
    );
  }

  detachAddress() {
    return Address(
      location: selectedBranch.value.location,
      landmark: selectedBranch.value.landmark,
      latitude: selectedBranch.value.latitude,
      longitude: selectedBranch.value.longitude,
      addressType: selectedBranch.value.addressType,
    );
  }
}
