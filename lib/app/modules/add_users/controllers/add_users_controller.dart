import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

class AddUsersController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  var thumbFile = File('').obs;
  var isUpdate = false.obs;
  var isLoading = false.obs;
  var userTypes = ['admin', 'manager', 'technician', 'customer'];
  var selectedUserType = 'manager'.obs;
  var selectedUser = User().obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      isUpdate(true);
      selectedUser.value = Get.arguments;
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

  pickThumb() async {
    thumbFile.value = (await FileProvider().pickFile(
        fileType: FileType.custom, allowedExtensions: ['png', 'jpeg']))!;
    String fileName = thumbFile.value.path.split('/').last;
    print('file url path ${thumbFile.value.path}');
    print('file picked path $fileName');

    imageController.text = fileName;
  }

  void setFields() {
    nameController.text = selectedUser.value.name;
    mobController.text = selectedUser.value.mobile.toString();
    mailController.text = selectedUser.value.email;
    imageController.text = selectedUser.value.image.split('/').last;
    selectedUserType.value = selectedUser.value.scope;
  }

  void createUser() {}

  void deleteUser() {}
}
