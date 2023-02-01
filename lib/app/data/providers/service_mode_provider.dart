import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/service_mode_model.dart';

class ServiceModeProvider extends GetConnect {
  Future<ServiceModeResult> getDummyData() async {
    final file = await rootBundle.loadString('assets/json/service_mode.json');
    final data = await jsonDecode(file);
    ServiceModeResult result = ServiceModeResult.fromJson(data);
    return result;
  }
}
