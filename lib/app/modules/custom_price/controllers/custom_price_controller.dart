import 'package:al_dana_admin/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPriceController extends GetxController {
  var isLoading = false.obs;
  var isUpdate = false.obs;
  var selectedPriceList = <ServicePrice>[ServicePrice()].obs;
  var priceList = <ServicePrice>[ServicePrice()].obs;
  var modeList = <ServiceMode>[].obs;
  var serviceModeControllerList =
      <TextEditingController>[TextEditingController()].obs;
  var variantControllerList =
      <TextEditingController>[TextEditingController()].obs;
  var priceControllerList =
      <TextEditingController>[TextEditingController()].obs;
  var serviceModeresult = ServiceModeResult().obs;
  var variantResult = VariantResult().obs;
  RxList<RxList<ServiceMode>> selectedModeLists = [RxList(<ServiceMode>[])].obs;
  RxList<RxList<Variant>> selectedVariantsList = [RxList(<Variant>[])].obs;

  @override
  void onInit() {
    super.onInit();
    getDetails();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  addPrice() {
    selectedPriceList.add(ServicePrice());
    selectedModeLists.add(RxList(<ServiceMode>[]));
    selectedVariantsList.add(RxList(<Variant>[]));
    serviceModeControllerList.add(TextEditingController());
    variantControllerList.add(TextEditingController());
    priceControllerList.add(TextEditingController());
    selectedPriceList.refresh();
    selectedModeLists.refresh();
    selectedVariantsList.refresh();
  }

  removePrice(int position) {
    selectedPriceList.removeAt(position);
    selectedModeLists.removeAt(position);
    selectedVariantsList.removeAt(position);
    serviceModeControllerList.removeAt(position);
    variantControllerList.removeAt(position);
    priceControllerList.removeAt(position);
    selectedPriceList.refresh();
  }

  void getDetails() async {
    isLoading(true);
    await getServiceModes();
    await getCarVariants();
    if (Get.arguments != null) {
      List<ServicePrice> priceList = Get.arguments;
      if (priceList.isNotEmpty) {
        isUpdate(true);
        selectedPriceList.value = Get.arguments;
        setFields();
      }
    }
    isLoading(false);
  }

  getServiceModes() async {
    serviceModeresult.value = await ServiceModeProvider().getModes();
    modeList.value = serviceModeresult.value.serviceModeList!;
    serviceModeControllerList.refresh();
  }

  getCarVariants() async {
    variantResult.value = await VariantProvider().getVariantList('');
    variantResult.refresh();
  }

  void createPrice() {
    for (int i = 0; i < selectedPriceList.length; i++) {
      selectedPriceList[i].serviceDetailId =
          selectedPriceList[0].serviceDetailId;
      selectedPriceList[i].serviceModeId =
          selectedModeLists[i].map((element) => element.id!).toList();
      selectedPriceList[i].price = double.parse(priceControllerList[i].text);
      selectedPriceList[i].variantId =
          selectedVariantsList[i].map((element) => element.id).toList();
    }

    Get.back(result: selectedPriceList.value);
  }

  void deletePrice() {
    selectedPriceList.clear();
    Get.back();
    Get.back(result: selectedPriceList.value);
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

  void setFields() {
    selectedModeLists.clear();
    selectedVariantsList.clear();
    serviceModeControllerList.clear();
    variantControllerList.clear();
    priceControllerList.clear();
    List<ServiceMode> modes = [];
    List<Variant> variants = [];
    for (int i = 0; i < selectedPriceList.length; i++) {
      modes.clear();
      variants.clear();

      modeList.forEach((element) {
        if (selectedPriceList[i].serviceModeId!.contains(element.id)) {
          modes.add(element);
        }
      });
      variantResult.value.variantList.forEach((e) {
        if (selectedPriceList[i].variantId!.contains(e.id)) {
          variants.add(e);
        }
      });

      selectedModeLists.add(RxList(modes));
      selectedVariantsList.add(RxList(variants));
      serviceModeControllerList.add(TextEditingController(
          text:
              selectedModeLists[i].map((element) => element.title).join(', ')));
      priceControllerList.add(
          TextEditingController(text: selectedPriceList[i].price.toString()));
      variantControllerList.add(TextEditingController());
    }

    selectedPriceList.refresh();
  }
}
