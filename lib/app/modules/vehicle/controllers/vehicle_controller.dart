import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

class VehicleController extends GetxController {
  var pageTitle = 'Manage Vehicle'.obs;
  var pageIndex = 0.obs;
  var brandResult = BrandResult(brandList: []).obs;
  var colorList = <VehicleColor>[].obs;
  var yearList = <VehicleYear>[].obs;

  var filterBrands = <Brand>[].obs;
  TextEditingController colorNameController = TextEditingController();
  var selectedYear = DateTime.now().obs;
  var selectedColor = const Color(0xff443a49).obs;

  @override
  void onInit() {
    super.onInit();
    getDetails();
  }



  void search({required String key}) {
    filterBrands.value = brandResult.value.brandList
        .where(
            (element) => element.name.toLowerCase().contains(key.toLowerCase()))
        .toList();
    filterBrands.refresh();
  }

  getDetails() {
    getbrands();
    getColors();
    getYears();
  }

  getbrands() async {
    brandResult.value = await BrandProvider().getBrandes();
    filterBrands.value = brandResult.value.brandList;
    brandResult.refresh();
    filterBrands.refresh();
  }

  getColors() async {
    colorList.value = (await ColorProvider().getDummyData()).colorList!;
    colorList.refresh();
  }

  getYears() async {
    yearList.value = (await YearProvider().getDummyData()).yearList!;
    yearList.refresh();
  }

  void addToYearList(DateTime dateTime) {
    bool isContain = false;
    for (VehicleYear year in yearList) {
      if (year.name == dateTime.year.toString()) {
        isContain = true;
      }
    }
    if (!isContain) {
      //need to call the year adding API and refresh the list
      yearList.add(VehicleYear(id: '10', name: dateTime.year.toString()));
    }
  }

  void addColorToList() {
    bool isContain = false;
    for (VehicleColor color in colorList) {
      if (color.code == colorToHexValue(selectedColor.value)) {
        isContain = true;
      }
    }
    if (!isContain) {
      //need to call the color adding API and refresh the list
      colorList.add(VehicleColor(
          id: '10',
          name: colorNameController.text,
          code: colorToHexValue(selectedColor.value)));
      colorList.refresh();
      Get.back();
    }
  }

  void deleteColor(VehicleColor color) {
    //need to call the color delete API and refresh the list
    colorList.remove(color);
    colorList.refresh();
    Get.back();
  }

  void deleteYear(VehicleYear year) {
    //need to call the year delete API and refresh the list
    yearList.remove(year);
    yearList.refresh();
    Get.back();
  }
}
