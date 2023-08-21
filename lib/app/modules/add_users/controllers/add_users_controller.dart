import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

class AddUsersController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var thumbFile = File('').obs;
  var isUpdate = false.obs;
  var isLoading = false.obs;
  var userTypes = ['admin', 'serviceManager', 'technician', 'customer'];
  var selectedUserType = 'serviceManager'.obs;
  var selectedUser = User().obs;

  var branchResult = BranchResult().obs;
  var categoryResult = CategoryResult().obs;
  var selectedBranch = Branch().obs;
  var selectedCategory = Category().obs;

  @override
  void onInit() {
    super.onInit();
    getDetails();
  }

  pickThumb() async {
    thumbFile.value = (await FileProvider().pickFile())!;
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
    usernameController.text = selectedUser.value.username;
    passwordController.text = selectedUser.value.password;
    selectedUserType.value = selectedUser.value.scope;
    selectedBranch.value = branchResult.value.branchList!
        .firstWhere((element) => element.id == selectedUser.value.branchId);
    branchController.text = selectedBranch.value.name;
  }

  Future<String> imageUpload() async {
    if (thumbFile.value.path.isNotEmpty) {
      var result = await FileProvider().uploadSingleFile(file: thumbFile.value);
      if (result['status'] == 'success') {
        return result['data'][0];
      }
    }
    return selectedUser.value.image;
  }

  void createUser() async {
    final imagePath = await imageUpload();

    final result = await UserProvider().signUp(
        user: User(
      name: nameController.text,
      email: mailController.text,
      mobile: mobController.text,
      image: imagePath,
      scope: selectedUserType.value,
      username: usernameController.text,
      password: passwordController.text,
      branchId: selectedBranch.value.id,
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

  void updateUser() async {
    final imagePath = await imageUpload();

    final result = await UserProvider().updateUser(
        user: User(
      id: selectedUser.value.id,
      name: nameController.text,
      email: mailController.text,
      mobile: mobController.text,
      image: imagePath,
      scope: selectedUserType.value,
      username: usernameController.text,
      password: passwordController.text,
      branchId: selectedBranch.value.id,
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

  void deleteUser() async {
    final result =
        await UserProvider().inactivateUser(user: selectedUser.value);

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

  void getDetails() async {
    await getBranches();
    await getCategory();
    if (Get.arguments != null) {
      isUpdate(true);
      selectedUser.value = Get.arguments;
      print('user ${jsonEncode(selectedUser.value)}');
      setFields();
    }
  }

  getBranches() async {
    log(Common().currentUser.scope);
    log('get brance calle');
    log(selectedUser.value.scope);

    log('get brance calle');
    if (selectedUser.value.scope == "superAdmin" ||
        Common().currentUser.scope == "superAdmin") {
      log('branch list called');
      branchResult.value = await BranchProvider().getBranches();
    }
    branchResult.refresh();
  }

  getCategory() async {
    categoryResult.value = await CategoryProvider().getCategories();
    categoryResult.refresh();
  }
}
