import 'package:al_dana_admin/app/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimeSlotsController extends GetxController {
  TextEditingController dateController =
      TextEditingController(text: DateFormat.yMd().format(DateTime.now()));
  var mainTabs = [
    "Default",
    "Custom",
  ].obs;
  var weekDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ].obs;
  var selectedDay = 'Monday'.obs;
  var timeSlotDefaultResult = TimeSlotResult().obs;
  var selectedDefaultTimeSlot = TimeSlot().obs;
  var selectedDate = DateFormat.yMd().format(DateTime.now()).obs;
  var timeSlotCustomResult = TimeSlotResult().obs;
  var selectedCustomTimeSlot = TimeSlot().obs;
  var tabIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getDetails();
  }

  void getDetails() async {
    await getDefaultTimeSlots();
    await getCustomTimeSlot();
  }

  getDefaultTimeSlots() async {
    timeSlotDefaultResult.value =
        await TimeSlotProvider().getDefaultTimeSlots();
    timeSlotDefaultResult.refresh();
    if (timeSlotDefaultResult.value.timeSlotList.isNotEmpty) {
      onSelectWeekDay(timeSlotDefaultResult.value.timeSlotList[0].id);
    }
  }

  onSelectWeekDay(String day) {
    selectedDefaultTimeSlot.value = timeSlotDefaultResult.value.timeSlotList
        .firstWhere(
            (element) => element.id.toLowerCase() == day.toLowerCase());
  }

  onSelectDate(String date) {
    selectedCustomTimeSlot.value = timeSlotCustomResult.value.timeSlotList
        .firstWhere(
            (element) => element.date.toLowerCase() == date.toLowerCase());
  }

  void deleteDefaultSlot(String slot) {
    //Need to call the slot delete API and refresh;
    selectedDefaultTimeSlot.value.slotes.removeWhere((e)=> e.id==  slot);
    selectedDefaultTimeSlot.refresh();
    Get.back();
  }
  void deleteCustomSlot(String slot) {
    //Need to call the slot delete API and refresh;
    selectedDefaultTimeSlot.value.slotes.removeWhere((e)=> e.id==  slot);
    selectedDefaultTimeSlot.refresh();
    Get.back();
  }

  getCustomTimeSlot() async {
    timeSlotCustomResult.value = await TimeSlotProvider().getCustomTimeSlots();
    timeSlotCustomResult.refresh();
    if (timeSlotCustomResult.value.timeSlotList.isNotEmpty) {
      onSelectWeekDay(timeSlotCustomResult.value.timeSlotList[0].day);
    }
  }

  chooseDate() async {
    DateTime pickedDate = await pickDate(firstDate: DateTime.now());
    selectedDate.value = DateFormat.yMd().format(pickedDate);
    dateController.text = selectedDate.value;
    if (timeSlotCustomResult.value.timeSlotList.isNotEmpty) {
      onSelectDate(selectedDate.value);
    }
  }
}
