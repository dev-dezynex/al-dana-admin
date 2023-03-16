import 'package:al_dana_admin/app/data/data.dart';
import 'package:get/get.dart';

class TimeSlotsController extends GetxController {
  var weekDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ].obs;
  var timeSlotResult = TimeSlotResult().obs;
  var selectedTimeSlot = TimeSlot().obs;
  var tabIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getDetails();
  }



  void getDetails() {
    getTimeSlots();
  }

  void getTimeSlots() async {
    timeSlotResult.value = await TimeSlotProvider().getDummyData();
    timeSlotResult.refresh();
  }

  onSelectWeekDay(int index) {
    for (TimeSlot slot in timeSlotResult.value.timeSlotList) {
      if (slot.day.toLowerCase() == weekDays[index].toLowerCase()) {
        selectedTimeSlot.value = slot;
      }
    }
  }

  void deleteSlot(String slot) {
    //Need to call the slot delete API and refresh;
    selectedTimeSlot.value.slotes.remove(slot);
    selectedTimeSlot.refresh();
    Get.back();
  }
}
