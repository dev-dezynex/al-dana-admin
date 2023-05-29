import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../data.dart';

class ServiceModeProvider extends GetConnect {
  Future<ServiceModeResult> getDummyData() async {
    final file = await rootBundle.loadString('assets/json/service_mode.json');
    final data = await jsonDecode(file);
    ServiceModeResult result = ServiceModeResult.fromJson(data);
    return result;
  }

  Future<ServiceModeResult> getModes() async {
    ServiceModeResult result;
    final response = await get(
      apiListServiceMode,
      headers: Auth().requestHeaders,
    );
    print('path $apiListServiceMode');
    print('response ${response.body}');
    if (response.statusCode == 401) {
      Auth().authFailed(response.body['message']);
    }
    result = ServiceModeResult.fromJson(response.body);

    return result;
  }
}
