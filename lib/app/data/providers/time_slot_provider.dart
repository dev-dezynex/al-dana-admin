import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../data.dart';
import '../models/time_slot_model.dart';

class TimeSlotProvider extends GetConnect {
  Future<TimeSlotResult> getDummyData() async {
    final file = await rootBundle.loadString('assets/json/time_slot.json');
    final data = await jsonDecode(file);
    TimeSlotResult result = TimeSlotResult.fromJson(data);
    return result;
  }

  Future<TimeSlotResult> getDefaultTimeSlots() async {
    TimeSlotResult result;
    Map<String, dynamic> qParams = {'filter[status]': 'true'};
    final response = await get(apiListActiveTimeSlot,
        query: qParams, headers: Auth().requestHeaders);
    print('auth ${Auth().requestHeaders}');
    print('qparams $qParams');
    print('path $apiListActiveTimeSlot');
    print('response ${response.body}');
    if (response.statusCode == 200) {
      result = TimeSlotResult.listFromJson(response.body);
    } else {
      result = TimeSlotResult.listFromJson(
          {"status": "error", "message": "Server error !", "data": []});
    }

    return result;
  }
  Future<TimeSlotResult> getCustomTimeSlots() async {
    TimeSlotResult result;
    Map<String, dynamic> qParams = {'filter[status]': 'true'};
    final response = await get(apiListActiveTimeSlot,
        query: qParams, headers: Auth().requestHeaders);
    print('auth ${Auth().requestHeaders}');
    print('qparams $qParams');
    print('path $apiListActiveTimeSlot');
    print('response ${response.body}');
    if (response.statusCode == 200) {
      result = TimeSlotResult.listFromJson(response.body);
    } else {
      result = TimeSlotResult.listFromJson(
          {"status": "error", "message": "Server error !", "data": []});
    }

    return result;
  }
}
