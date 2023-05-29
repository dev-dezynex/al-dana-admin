import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

class AddPackageController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController serviceModeController = TextEditingController();
  TextEditingController thumbController = TextEditingController();

  var bgCardColor = const Color(0xffFF3868).obs;
  var isUpdate = false.obs;
  var isLoading = false.obs;
  var isCustomBranch = false.obs;
  var thumbFile = File('').obs;
  var modeList = <ServiceMode>[].obs;

  var branchResult = BranchResult().obs;
  var serviceResult = ServiceResult().obs;

  var selectedBranchList = <Branch>[].obs;
  var selectedServices = <Service>[].obs;
  var selectedPackage = PackageModel(
      packageDetailList: [PackageDetails(serviceModeId: [], services: [])]).obs;
  var selectedModeList = <ServiceMode>[].obs;
  RxList<RxList<ServiceMode>> selectedModeLists = [RxList(<ServiceMode>[])].obs;
  // RxList<RxList<Service>> selectedServiceLists = [RxList(<Service>[])].obs;
  var branchControllerList =
      <TextEditingController>[TextEditingController()].obs;
  var serviceControllerList =
      <TextEditingController>[TextEditingController()].obs;
  var serviceModeControllerList =
      <TextEditingController>[TextEditingController()].obs;
  var priceControllerList =
      <TextEditingController>[TextEditingController()].obs;

  @override
  void onInit() {
    super.onInit();
    getDetails();
  }

  getDetails() async {
    isLoading(true);
    await getBranches();
    await getServices();
    await getServiceModes();
    if (Get.arguments != null) {
      isUpdate(true);
      selectedPackage.value = Get.arguments;
      setFields();
    }
    isLoading(false);
  }

  void setFields() {
    clearList();
    titleController.text = selectedPackage.value.title!;
    descController.text = selectedPackage.value.desc!;
    thumbController.text = selectedPackage.value.image!.split('/').last;
    priceController.text = selectedPackage.value.price.toString();
    bgCardColor.value = hexToColor(selectedPackage.value.bgCardColor!);
    if (selectedPackage.value.packageDetailList!.isNotEmpty) {
      isCustomBranch(true);
      for (int i = 0;
          i < selectedPackage.value.packageDetailList!.length;
          i++) {
        selectedBranchList
            .add(selectedPackage.value.packageDetailList![i].branch!);
        selectedModeList.value =
            selectedPackage.value.packageDetailList![i].serviceModeId!;
        selectedModeLists.add(
            RxList(selectedPackage.value.packageDetailList![i].serviceModeId!));
        // selectedServiceLists
        //     .add(RxList(selectedPackage.value.packageDetailList![i].services!));

        branchControllerList.add(TextEditingController(
            text: selectedPackage.value.packageDetailList![i].branch!.name));
        serviceControllerList.add(TextEditingController());
        serviceModeControllerList.add(TextEditingController(
            text: selectedPackage.value.packageDetailList![i].serviceModeId!
                .map((e) => e.title)
                .join(', ')));
        priceControllerList.add(TextEditingController(
            text:
                selectedPackage.value.packageDetailList![i].price.toString()));
      }
    }
  }

  clearList() {
    selectedBranchList.clear();
    selectedServices.clear();
    // selectedServiceLists.clear();
    selectedModeLists.clear();
    branchControllerList.clear();
    serviceControllerList.clear();
    serviceModeControllerList.clear();
    priceControllerList.clear();
  }

  getBranches() async {
    branchResult.value = await BranchProvider().getBranches();
    branchResult.refresh();
  }

  getServices() async {
    serviceResult.value = await ServiceProvider().getServices();
    serviceResult.refresh();
  }

  getServiceModes() async {
    modeList.value = (await ServiceModeProvider().getModes()).serviceModeList!;
    modeList.refresh();
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
    return selectedPackage.value.image!;
  }

  void createPackage() async {
    isLoading(true);
    String imagePath = await imageUpload();
    var result = await PackageProvider().insertPackage(PackageModel(
        title: titleController.text,
        desc: descController.text,
        image: imagePath,
        price: double.parse(priceController.text),
        bgCardColor: colorToHexValue(bgCardColor.value),
        packageDetailList: getPackageDetails()));

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

  void updatePackage() async {
    isLoading(true);
    String imagePath = await imageUpload();
    var result = await PackageProvider().updatePackage(PackageModel(
        id: selectedPackage.value.id,
        title: titleController.text,
        desc: descController.text,
        image: imagePath,
        price: double.parse(priceController.text),
        bgCardColor: colorToHexValue(bgCardColor.value),
        packageDetailList: getPackageDetails()));

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

  void deletePackage() async {
    isLoading(true);
    var result =
        await PackageProvider().deletePackage(selectedPackage.value.id!);
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

  void chooseMode(BuildContext context,
      {required RxList<ServiceMode> selectedModesList,
      required TextEditingController textEditingController}) {
    modeSelectionBottomSheet(
        context: context,
        modeList: modeList,
        selectedModeList: selectedModesList,
        isMultiSelect: true,
        onModeSelected: (ServiceMode mode) {
          if (selectedModesList.any((e) => mode.id == e.id)) {
            selectedModesList.removeWhere((e) => e.id == mode.id);
          } else {
            selectedModesList.add(mode);
          }

          textEditingController.text =
              selectedModesList.map((e) => e.title).join(', ');
          modeList.refresh();
        },
        onSubmit: () {
          Get.back();
        });
  }

  addBranch({ServiceDetails? serviceDetails}) {
    selectedPackage.value.packageDetailList!
        .add(PackageDetails(services: [], serviceModeId: []));
    selectedModeLists.add(RxList(<ServiceMode>[]));
    branchControllerList.add(TextEditingController());
    serviceControllerList.add(TextEditingController());
    serviceModeControllerList.add(TextEditingController());
    priceControllerList.add(TextEditingController());
    selectedPackage.refresh();
  }

  void removeBranch(int position) {
    selectedPackage.value.packageDetailList!.removeAt(position);
    selectedModeLists.removeAt(position);
    branchControllerList.removeAt(position);
    serviceControllerList.removeAt(position);
    serviceModeControllerList.removeAt(position);
    priceControllerList.removeAt(position);
    selectedPackage.refresh();
  }

  getPackageDetails() {
    List<PackageDetails> packageDetails = [];
    if (isCustomBranch.value) {
      for (int i = 0;
          i < selectedPackage.value.packageDetailList!.length;
          i++) {
        selectedPackage.value.packageDetailList![i].branchId =
            selectedBranchList[i].id;
        selectedPackage.value.packageDetailList![i].price =
            double.parse(priceControllerList[i].text);
        selectedPackage.value.packageDetailList![i].serviceModeId =
            selectedModeLists[i];
        // selectedPackage.value.packageDetailList![i].services =
        //     selectedServiceLists[i];

        packageDetails.add(selectedPackage.value.packageDetailList![i]);
      }
    } else {
      for (int i = 0; i < branchResult.value.branchList!.length; i++) {
        if (selectedPackage.value.packageDetailList!.length <= i) {
          selectedPackage.value.packageDetailList!.add(PackageDetails());
        }
        selectedPackage.value.packageDetailList![i].branchId =
            branchResult.value.branchList![i].id;
        selectedPackage.value.packageDetailList![i].price =
            double.parse(priceController.text);
        selectedPackage.value.packageDetailList![i].serviceModeId =
            selectedModeList;
        selectedPackage.value.packageDetailList![i].services = selectedServices;
        packageDetails.add(selectedPackage.value.packageDetailList![i]);
      }
    }

    return packageDetails;
  }
}
