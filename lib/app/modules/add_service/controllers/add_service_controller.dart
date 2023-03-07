import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

class AddServiceController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  // TextEditingController workController = TextEditingController();
  TextEditingController thumbController = TextEditingController();
  var branchResult = BranchResult().obs;
  var categoryResult = CategoryResult().obs;
  var workResult = WorkResult().obs;
  var isUpdate = false.obs;
  var isLoading = false.obs;
  var thumbFile = File('').obs;
  var bgCardColor = const Color(0xff09DDBD).obs;
  var selectedBranch = <Branch>[].obs;
  var selectedWork = <Work>[].obs;
  var selectedService = Service(spareCategory: SpareCategory()).obs;
  var selectedCategory = Category().obs;
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
    titleController.text = selectedService.value.title;
    descController.text = selectedService.value.desc;
    priceController.text = selectedService.value.price.toString();
    thumbController.text = selectedService.value.image.split('/').last;
    for (Branch branch in branchResult.value.branchList!) {
      if (branch.serviceList!.contains(selectedService.value.id)) {
        selectedBranch.add(branch);
      }
    }
    selectedBranch.refresh();
    selectedCategory.value = categoryResult.value.categoryList.firstWhere(
        (element) => element.id == selectedService.value.categoryId);
    categoryController.text = selectedCategory.value.title;
    // selectedBranch.value = selectedService.value.branchList;
    // selectedWork.value = selectedService.value.work;
  }

  void getDetails() async {
    await getBranches();
    await getCategories();
    //getWorks();

    if (Get.arguments != null) {
      isUpdate.value = true;
      selectedService.value = Get.arguments;
      setFields();
    }
  }

  getBranches() async {
    branchResult.value = await BranchProvider().getBranches();
    branchResult.refresh();
  }

  getCategories() async {
    categoryResult.value = await CategoryProvider().getCategories();
    categoryResult.refresh();
  }

  void getWorks() async {
    workResult.value = await WorkProvider().getDummyData();
    workResult.refresh();
  }

  Future<String> imageUpload() async {
    if (thumbFile.value.path.isNotEmpty) {
      var result = await FileProvider().uploadSingleFile(file: thumbFile.value);
      if (result['status'] == 'success') {
        return result['data'][0];
      }
    }
    return selectedService.value.image;
  }

  void createService() async {
    isLoading(true);
    String imagePath = await imageUpload();
    var result = await ServiceProvider().addOrUpdateService(
        service: Service(
      title: titleController.text,
      categoryId: selectedCategory.value.id,
      desc: descController.text,
      bgCardColor: colorToHexValue(bgCardColor.value),
      image: imagePath,
      price: double.parse(priceController.text),
    ));
    if (result.status == 'success') {
      await updateBranchServices(result.service!);
      Get.back(result: true);
    } else {
      Get.snackbar('Error', result.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }
    isLoading(false);
  }

  updateBranchServices(Service service) async {
    for (Branch branch in selectedBranch) {
      if (!branch.serviceList!.contains(service.id)) {
        branch.serviceList!.add(service.id);
        await BranchProvider().addOrUpdateBranch(branch: branch);
      }
    }
  }

  void updateService() async {
    isLoading(true);
    String imagePath = await imageUpload();
    var result = await ServiceProvider().addOrUpdateService(
        service: Service(
      id: selectedService.value.id,
      title: titleController.text,
      categoryId: selectedCategory.value.id,
      desc: descController.text,
      bgCardColor: colorToHexValue(bgCardColor.value),
      image: imagePath,
      price: double.parse(priceController.text),
    ));
    if (result.status == 'success') {
      await updateBranchServices(selectedService.value);
      Get.back(result: true);
    } else {
      Get.snackbar('Error', result.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }
    isLoading(false);
  }

  void deleteService() async {
    final result =
        await ServiceProvider().deleteService(service: selectedService.value);
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
