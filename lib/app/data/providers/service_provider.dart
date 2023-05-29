import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../data.dart';

class ServiceProvider extends GetConnect {
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

//pass the service id to update else insert
  Future<ServiceResult> addOrUpdateService({required Service service}) async {
    final ServiceResult result;
    final Response<dynamic> response;
    if (service.id.isEmpty) {
      response = await post(apiAddService, service.toJson(),
          headers: Auth().requestHeaders);
      print('path $apiAddService');
    } else {
      response = await put('$apiUpdateService/${service.id}', service.toJson(),
          headers: Auth().requestHeaders);
      print('path $apiUpdateService/${service.id}');
    }
    print('body ${jsonEncode(service)}');
    log('body ${jsonEncode(service)}');
    print('response ${response.body}');
    print('Auth ${Auth().requestHeaders}');

    result = ServiceResult.fromJson(response.body);

    return result;
  }

  Future<ServiceResult> getServices() async {
    ServiceResult result;

    final response = await get(
      apiListService,
      headers: Auth().requestHeaders,
    ).timeout(Duration(minutes: 1));

    print('auth ${Auth().requestHeaders}');
    print('path $apiListService');
    print('responseCode ${response.statusCode}');
    print('response ${response.body}');
    if (response.statusCode == 401) {
      Auth().authFailed(response.body['message']);
    }
    result = ServiceResult.listFromJson(response.body);
    return result;
  }

  Future<ServiceResult> deleteService({required Service service}) async {
    ServiceResult result;
    final response = await delete(
      '$apiDeleteService/${service.id}',
      headers: Auth().requestHeaders,
    );
    print('path $apiDeleteService');
    print('response ${response.body}');
    result = ServiceResult.fromJson(response.body);

    return result;
  }
}
