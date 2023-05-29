import 'dart:convert';
import 'dart:developer';

import 'package:al_dana_admin/app/data/constants/api_routes.dart';
import 'package:al_dana_admin/app/data/constants/common.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/package_model.dart';

class PackageProvider extends GetConnect {
  Future<PackageResult> getDummyData() async {
    final file = await rootBundle.loadString('assets/json/package.json');
    final data = await jsonDecode(file);
    PackageResult result = PackageResult.fromJson(data);
    return result;
  }

  Future<PackageResult> getActivePackageList() async {
    final response =
        await get(apiListActivePackage, headers: Auth().requestHeaders);
    if (response.statusCode == 401) {
      Auth().authFailed(response.body['message']);
    }
    print('path $apiListActivePackage');
    print('auth ${Auth().requestHeaders}');
    log('response ${jsonEncode(response.body)}');
    return PackageResult.listFromJson(response.body);
  }

  Future<PackageResult> insertPackage(PackageModel packageModel) async {
    final response = await post(apiAddPackage, packageModel.toJson(),
        headers: Auth().requestHeaders);
    if (response.statusCode == 401) {
      Auth().authFailed(response.body['message']);
    }
    print('path $apiAddPackage');
    print('body ${jsonEncode(packageModel.toJson())}');
    print('auth ${Auth().requestHeaders}');
    print('response ${response.body}');
    return PackageResult.fromJson(response.body);
  }

  Future<PackageResult> updatePackage(PackageModel packageModel) async {
    final response = await put(
        '$apiUpdatePackage/${packageModel.id}', packageModel.toJson(),
        headers: Auth().requestHeaders);
    if (response.statusCode == 401) {
      Auth().authFailed(response.body['message']);
    }
    print('path $apiUpdatePackage/${packageModel.id}');
    log('body ${jsonEncode(packageModel.toJson())}');
    print('auth ${Auth().requestHeaders}');
    log('response ${response.body}');
    return PackageResult.fromJson(response.body);
  }

  Future<PackageResult> deletePackage(String packageId) async {
    final response = await delete('$apiDeletePackage/$packageId',
        headers: Auth().requestHeaders);
    if (response.statusCode == 401) {
      Auth().authFailed(response.body['message']);
    }
    print('path $apiDeletePackage/$packageId');
    print('auth ${Auth().requestHeaders}');
    print('response ${response.body}');
    return PackageResult.fromJson(response.body);
  }
}
