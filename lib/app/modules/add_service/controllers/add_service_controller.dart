import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

class AddServiceController extends GetxController {
  //main form fields
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController periodController = TextEditingController();
  TextEditingController spareCategoryController = TextEditingController();
  // TextEditingController branchController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController serviceModeController = TextEditingController();
  TextEditingController thumbController = TextEditingController();

//main conditions
  var isCustomBranch = false.obs;
  var isUpdate = false.obs;
  var isLoading = false.obs;
//api datas
  var branchResult = BranchResult().obs;
  var categoryResult = CategoryResult().obs;
  var spareCategoryResult = SpareCategoryResult().obs;
//selected Elements
  var thumbFile = File('').obs;
  var bgCardColor = const Color(0xff09DDBD).obs;
  var selectedCategory = Category().obs;
  var selectedSpareCategory = SpareCategory().obs;
//multi selected elements
  var selectedBranchList = <Branch>[].obs;
  var selectedService = Service(serviceDetails: [
    ServiceDetails(servicePriceList: [], serviceModeIdList: [])
  ]).obs;
  var modeList = <ServiceMode>[].obs;
  var selectedModeList = <ServiceMode>[].obs;
  RxList<RxList<ServiceMode>> selectedModeLists = [RxList(<ServiceMode>[])].obs;
  var branchControllerList =
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

  pickThumb() async {
    thumbFile.value = (await FileProvider().pickFile(
        fileType: FileType.custom, allowedExtensions: ['png', 'jpeg']))!;
    String fileName = thumbFile.value.path.split('/').last;
    print('file url path ${thumbFile.value.path}');
    print('file picked path $fileName');

    thumbController.text = fileName;
  }

  void setFields() {
    print(
        'In###########################################################################');
    titleController.text = selectedService.value.title;
    descController.text = selectedService.value.desc;
    priceController.text = selectedService.value.price.toString();
    thumbController.text = selectedService.value.image.split('/').last;
    durationController.text = selectedService.value.duration;
    periodController.text = selectedService.value.period.toString();
    bgCardColor.value = hexToColor(selectedService.value.bgCardColor);
    selectedCategory.value = categoryResult.value.categoryList.firstWhere(
        (element) => element.id == selectedService.value.categoryId);
    categoryController.text = selectedCategory.value.title;
    selectedSpareCategory.value = spareCategoryResult.value.spareCategoryList!
        .firstWhere(
            (element) => element.id == selectedService.value.spareCategory,
            orElse: () => SpareCategory());
    spareCategoryController.text = selectedSpareCategory.value.name;

    if (selectedService.value.serviceDetails.isNotEmpty) {
      isCustomBranch(true);
      branchControllerList.clear();
      serviceModeControllerList.clear();
      priceControllerList.clear();
      selectedBranchList.clear();
      selectedModeLists.clear();
      List<ServiceMode> modes = [];
      for (int i = 0; i < selectedService.value.serviceDetails.length; i++) {
        modes.clear();
        modeList.forEach((element) {
          if (selectedService.value.serviceDetails[i].serviceModeIdList!
              .contains(element.id)) {
            modes.add(element);
          }
        });
        selectedModeLists.add(RxList(modes));
        selectedBranchList.add(branchResult.value.branchList!.firstWhere(
            (element) =>
                element.id ==
                selectedService.value.serviceDetails[i].branchId));
        branchControllerList
            .add(TextEditingController(text: selectedBranchList[i].name));
        //filling branch form
        serviceModeControllerList.add(TextEditingController(
            text: selectedModeLists[i]
                .map((element) => element.title)
                .join(', ')));
        priceControllerList.add(TextEditingController(
            text: selectedService.value.serviceDetails[i].price.toString()));
      }
    }
    selectedService.refresh();
  }

  void getDetails() async {
    isLoading(true);
    await getBranches();
    await getCategories();
    await getSpareCategories();
    await getServiceMode();

    if (Get.arguments != null) {
      isUpdate.value = true;
      selectedService.value = Get.arguments;
      setFields();
    }
    isLoading(false);
  }

  getBranches() async {
    branchResult.value = await BranchProvider().getBranches();
    branchResult.refresh();
  }

  getCategories() async {
    categoryResult.value = await CategoryProvider().getCategories();
    categoryResult.refresh();
  }

  getSpareCategories() async {
    spareCategoryResult.value =
        await SpareCategoryProvider().listActiveSpareCategory();
    spareCategoryResult.refresh();
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
            duration: durationController.text,
            period: periodController.text.isNotEmpty
                ? int.parse(periodController.text)
                : 0,
            spareCategory: selectedSpareCategory.value.id,
            serviceDetails: getServiceDetails()));
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
      duration: durationController.text,
      period: periodController.text.isNotEmpty
          ? int.parse(periodController.text)
          : 0,
      spareCategory: selectedSpareCategory.value.id,
      serviceDetails: getServiceDetails(),
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

  List<ServiceDetails> getServiceDetails() {
    List<ServiceDetails> serviceDetails = [];
    if (isCustomBranch.value) {
      for (int i = 0; i < selectedService.value.serviceDetails.length; i++) {
        selectedService.value.serviceDetails[i].serviceId =
            selectedService.value.id;
        selectedService.value.serviceDetails[i].branchId =
            selectedBranchList[i].id;
        selectedService.value.serviceDetails[i].price =
            double.parse(priceControllerList[i].text);
        selectedService.value.serviceDetails[i].serviceModeIdList =
            selectedModeLists[i].map((element) => element.id!).toList();
        serviceDetails.add(selectedService.value.serviceDetails[i]);
      }
    } else {
      for (int i = 0; i < branchResult.value.branchList!.length; i++) {
        if (selectedService.value.serviceDetails.length <= i) {
          selectedService.value.serviceDetails.add(ServiceDetails());
        }
        selectedService.value.serviceDetails[i].branchId =
            branchResult.value.branchList![i].id;
        selectedService.value.serviceDetails[i].price =
            double.parse(priceController.text);
        selectedService.value.serviceDetails[i].serviceModeIdList =
            selectedModeList.map((element) => element.id!).toList();
        if (selectedService
            .value.serviceDetails[0].servicePriceList!.isNotEmpty) {
          addCustomPriceList(
              i, selectedService.value.serviceDetails[0].servicePriceList!,
              refresh: false);
        }
        serviceDetails.add(selectedService.value.serviceDetails[i]);
      }
    }

    return serviceDetails;
  }

//this function will add a custom price aganist servicemode and variant
  addCustomPriceList(int position, List<ServicePrice> servicePrice,
      {bool refresh = true}) {
    selectedService.value.serviceDetails[position].servicePriceList =
        servicePrice;
    selectedService.value.serviceDetails[position].servicePriceList!
        .forEach((element) {
      element.serviceDetailId =
          selectedService.value.serviceDetails[position].id;
    });
    if (refresh) {
      selectedService.refresh();
    }
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

  void chooseMode(BuildContext context,
      {required RxList<ServiceMode> selectedModesList,
      required TextEditingController textEditingController}) {
    modeSelectionBottomSheet(
        context: context,
        modeList: modeList,
        selectedModeList: selectedModesList,
        isMultiSelect: true,
        onModeSelected: (ServiceMode mode) {
          if (selectedModesList.contains(mode)) {
            selectedModesList.remove(mode);
          } else {
            selectedModesList.add(mode);
          }

          textEditingController.text =
              selectedModesList.map((e) => e.title).join(', ');
        },
        onSubmit: () {
          Get.back();
        });
  }

  getServiceMode() async {
    modeList.value = (await ServiceModeProvider().getModes()).serviceModeList!;
    modeList.refresh();
  }

  addBranch({ServiceDetails? serviceDetails}) {
    selectedService.value.serviceDetails
        .add(ServiceDetails(serviceModeIdList: [], servicePriceList: []));
    selectedModeLists.add(RxList(<ServiceMode>[]));
    branchControllerList.add(TextEditingController());
    serviceModeControllerList.add(TextEditingController());
    priceControllerList.add(TextEditingController());
    selectedService.refresh();
  }

  void removeBranch(int position) {
    selectedService.value.serviceDetails.removeAt(position);
    selectedModeLists.removeAt(position);
    branchControllerList.removeAt(position);
    serviceModeControllerList.removeAt(position);
    priceControllerList.removeAt(position);
    selectedService.refresh();
  }
}
