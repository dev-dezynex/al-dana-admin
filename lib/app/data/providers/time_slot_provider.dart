import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/time_slot_model.dart';

class TimeSlotProvider extends GetConnect {
  Future<TimeSlotResult> getDummyData() async {
    final file = await rootBundle.loadString('assets/json/time_slot.json');
    final data = await jsonDecode(file);
    TimeSlotResult result = TimeSlotResult.fromJson(data);
    return result;
  }
}
