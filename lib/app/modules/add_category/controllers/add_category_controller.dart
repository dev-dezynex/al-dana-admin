import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

class AddCategoryController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController serviceModeController = TextEditingController();
  TextEditingController thumbController = TextEditingController();

  var bgCardColor = const Color(0xff443a49).obs;
  var isUpdate = false.obs;
  var isLoading = false.obs;
  var thumbFile = File('').obs;

  var modeList = <ServiceMode>[].obs;
  var selectedModeList = <ServiceMode>[].obs;
  var selectedCategory = Category().obs;
  @override
  void onInit() {
    super.onInit();

    getDetails();
  }



  void createCategory() {}

  void deleteCategory() {}

  pickThumb() async {
    thumbFile.value = (await FileProvider().pickFile(
        fileType: FileType.custom, allowedExtensions: ['png', 'jpeg']))!;
    String fileName = thumbFile.value.path.split('/').last;
    print('file url path ${thumbFile.value.path}');
    print('file picked path $fileName');

    thumbController.text = fileName;
  }

  void chooseMode(BuildContext context) {
    modeSelectionBottomSheet(
        context: context,
        modeList: modeList,
        selectedModeList: selectedModeList,
        isMultiSelect: true,
        onModeSelected: (ServiceMode mode) {
          if (selectedModeList.contains(mode)) {
            selectedModeList.remove(mode);
          } else {
            selectedModeList.add(mode);
          }

          serviceModeController.text =
              selectedModeList.value.map((e) => e.title).join(', ');
        },
        onSubmit: () {
          Get.back();
        });
  }

  void getDetails() async {
    await getModeList();
    if (Get.arguments != null) {
      isUpdate.value = true;
      selectedCategory.value = Get.arguments;
      setFields();
    }
  }

  getModeList() async {
    modeList.value =
        (await ServiceModeProvider().getDummyData()).serviceModeList!;
    modeList.refresh();
  }

  void setFields() {
    titleController.text = selectedCategory.value.title;
    descController.text = selectedCategory.value.desc;
    for (ServiceMode mode in selectedCategory.value.modeList) {
      if (modeList.firstWhereOrNull((element) => element.id==mode.id)!=null) {
        print("contains");
        selectedModeList.add(mode);
      }else{
         print("not contains");
      }
    }
    serviceModeController.text =
        selectedModeList.map((element) => element.title).join(', ');
    thumbController.text = selectedCategory.value.image.split('/').last;
    bgCardColor.value = hexToColor(selectedCategory.value.bgCardColor);
  }
}
