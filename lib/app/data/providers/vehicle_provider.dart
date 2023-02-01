import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/vehicle_model.dart';

class VehicleProvider extends GetConnect {
  Future<VehicleResult> getDummyData() async {
    final file = await rootBundle.loadString('assets/json/vehicle.json');
    final data = await jsonDecode(file);
    VehicleResult result = VehicleResult.fromJson(data);
    return result;
  }
}
