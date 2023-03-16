import 'dart:io';

import 'package:al_dana_admin/app/data/data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddBannerController extends GetxController {
  TextEditingController branchController = TextEditingController();
  TextEditingController thumbController = TextEditingController();

  var isUpdate = false.obs;
  var isLoading = false.obs;
  var thumbFile = File('').obs;
  var branchResult = BranchResult().obs;
  var selectedBranch = Branch().obs;
  var selectedBanner = BannerModel().obs;
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
    return selectedBanner.value.image!;
  }

  void createBanner() async {
    final imagePath = await imageUpload();
    final result = await BannerProvider().addOrUpdateBanner(
        banner: BannerModel(
            sId: isUpdate.value ? selectedBanner.value.sId : '',
            branchId: selectedBranch.value.id,
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
  }

  void deleteBanner() async {
    var result =
        await BannerProvider().deleteBanner(banner: selectedBanner.value);
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

  void getDetails() async {
    isLoading(true);
    await getBranches();
    if (Get.arguments != null) {
      isUpdate(true);
      selectedBanner.value = Get.arguments;
      setFields();
    }
    isLoading(false);
  }

  getBranches() async {
    branchResult.value = await BranchProvider().getBranches();
    branchResult.refresh();
  }

  void setFields() {
    selectedBranch.value = branchResult.value.branchList!
        .firstWhere((element) => element.id == selectedBanner.value.branchId);
    branchController.text = selectedBranch.value.name;
    thumbController.text = selectedBanner.value.image!.split('/').last;
  }

  pickThumb() async {
    thumbFile.value = (await FileProvider().pickFile(
        fileType: FileType.custom, allowedExtensions: ['png', 'jpeg','webp']))!;
    String fileName = thumbFile.value.path.split('/').last;
    print('file url path ${thumbFile.value.path}');
    print('file picked path $fileName');

    thumbController.text = fileName;
  }
}
