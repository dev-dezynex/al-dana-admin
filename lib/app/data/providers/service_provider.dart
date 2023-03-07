import 'dart:convert';

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
          headers: Auth.requestHeaders);
      print('path $apiAddService');
    } else {
      response = await put('$apiUpdateService/${service.id}', service.toJson(),
          headers: Auth.requestHeaders);
      print('path $apiUpdateService/${service.id}');
    }
    print('body ${service.toJson()}');
    print('response ${response.body}');

    result = ServiceResult.fromJson(response.body);

    return result;
  }

  Future<ServiceResult> getServices() async {
    ServiceResult result;
    Map<String, dynamic> qParams = {'filter[status]': 'true'};
    final response = await get(
      apiListService,
      query: qParams,
      headers: Auth.requestHeaders,
    );
    print('qparams $qParams');
    print('path $apiListService');
    print('response ${response.body}');
    result = ServiceResult.listFromJson(response.body);
    return result;
  }

  Future<ServiceResult> deleteService({required Service service}) async {
    ServiceResult result;
    final response = await delete(
      '$apiDeleteService/${service.id}',
      headers: Auth.requestHeaders,
    );
    print('path $apiDeleteService');
    print('response ${response.body}');
    result = ServiceResult.fromJson(response.body);

    return result;
  }
}
