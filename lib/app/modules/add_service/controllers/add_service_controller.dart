import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

class AddServiceController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController workController = TextEditingController();
  TextEditingController thumbController = TextEditingController();
  var branchResult = BranchResult().obs;
  var workResult = WorkResult().obs;
  var isUpdate = false.obs;
  var isLoading = false.obs;
  var thumbFile = File('').obs;
  var bgCardColor = const Color(0xff09DDBD).obs;
  var selectedBranch = <Branch>[].obs;
  var selectedWork = <Work>[].obs;
  var selectedService = Service(spareCategory: SpareCategory()).obs;
  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      isUpdate.value = true;
      selectedService.value = Get.arguments;
      setFields();
    }
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

  void createService() {}

  void deleteService() {}

  void setFields() {
    titleController.text = selectedService.value.title;
    subTitleController.text = selectedService.value.subTitle;
    descController.text = selectedService.value.desc;
    priceController.text = selectedService.value.price.toString();
    thumbController.text = selectedService.value.image.split('/').last;
    selectedBranch.value = selectedService.value.branchList;
    selectedWork.value = selectedService.value.work;
  }

  void getDetails() {
    getBranches();
    getWorks();
  }

  void getBranches() async {
    branchResult.value = await BranchProvider().getDummyData();
    branchResult.refresh();
  }

  void getWorks() async {
    workResult.value = await WorkProvider().getDummyData();
    workResult.refresh();
  }
}
