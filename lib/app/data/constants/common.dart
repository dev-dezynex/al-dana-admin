import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../data.dart';

final storage = GetStorage();

pickDate({
  DateTime? initDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  var selectedDate = DateTime.now();
  DateTime? pickedDate = await showDatePicker(
    context: Get.context!,
    initialDate: initDate ?? DateTime.now(),
    firstDate: firstDate ?? DateTime(1900),
    lastDate: lastDate ?? DateTime(2050),

    initialEntryMode: DatePickerEntryMode.calendarOnly,
    // initialDatePickerMode: DatePickerMode.year,
    helpText: 'Select Date',
    cancelText: 'Close',
    confirmText: 'Confirm',
    errorFormatText: 'Enter valid date',
    errorInvalidText: 'Enter valid date range',
    fieldLabelText: 'Date',
    fieldHintText: 'Month/Date/Year',
    // selectableDayPredicate: disableDate
  );
  if (pickedDate != null && pickedDate != selectedDate) {
    selectedDate = pickedDate;
  }

  return selectedDate;
}

final DateFormat outputDateFormat = DateFormat('dd-MM-yyyy');
final DateFormat outputDateFormat2 = DateFormat('EEE, dd MMM yyyy');

class Common {
  User currentUser = User.fromJson(storage.read(user_details) ?? {});
  Branch selectedBranch = Branch.fromJson(storage.read(selected_branch) ?? {});
  Vehicle selectedVehicle =
      Vehicle.fromJson(storage.read(selected_vehicle) ?? {});
  ServiceMode selectedMode =
      ServiceMode.fromJson(storage.read(selected_mode) ?? {});
  List<dynamic> selectedServiceList = storage.read(selected_service) ?? [];
}
