import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/service_model.dart';

class ServiceProvider extends GetConnect {
  getServices() {}

  Future<ServiceResult> getDummyData() async {
    final file = await rootBundle.loadString('assets/json/service.json');
    final data = await jsonDecode(file);
    ServiceResult result = ServiceResult.fromJson(data);
    return result;
  }

  Future<ServiceResult> getExtraDummyData() async {
    final file = await rootBundle.loadString('assets/json/extra_service.json');
    final data = await jsonDecode(file);
    ServiceResult result = ServiceResult.fromJson(data);
    return result;
  }
}
