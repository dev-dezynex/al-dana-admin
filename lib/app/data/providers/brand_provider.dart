import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/api_routes.dart';
import '../constants/common.dart';
import '../models/brand_model.dart';

class BrandProvider extends GetConnect {
  Future<BrandResult> getDummyData() async {
    final file = await rootBundle.loadString('assets/json/brand.json');
    final data = await jsonDecode(file);
    
    BrandResult result = BrandResult.fromJson(data);
    return result;
  }



//add brand id for update else insert
  Future<BrandResult> addOrUpdateBrand({required Brand brand}) async {
    final BrandResult result;
    final Response<dynamic> response;
    if (brand.id.isEmpty) {
      response = await post(apiAddCarBrand, brand.toJson(),
          headers: Auth().requestHeaders);
      print('path $apiAddCarBrand');
    } else {
      response = await put('$apiUpdateCarBrand/${brand.id}', brand.toJson(),
          headers: Auth().requestHeaders);
      print('path $apiUpdateCarBrand/${brand.id}');
    }
    print('body ${brand.toJson()}');
    print('response ${response.body}');

    result = BrandResult.fromJson(response.body);

    return result;
  }

  Future<BrandResult> getBrandes() async {
    BrandResult result;
    Map<String, dynamic> qParams = {'filter[status]': 'true'};
    final response =
        await get(apiListCarBrand, query: qParams, headers: Auth().requestHeaders);
    print('auth ${Auth().requestHeaders}');
    print('qparams $qParams');
    print('path $apiListCarBrand');
    print('response ${response.body}');
    if (response.statusCode == 200) {
      result = BrandResult.listFromJson(response.body);
    } else {
      result = BrandResult.listFromJson(
          {"status": "error", "message": "Server error !", "data": []});
    }

    return result;
  }

  Future<BrandResult> deleteBrand({required Brand brand}) async {
    BrandResult result;
    final response = await delete(
      '$apiDeleteCarBrand/${brand.id}',
      headers: Auth().requestHeaders,
    );

    print('path $apiDeleteCarBrand');
    print('response ${response.body}');
    if (response.statusCode == 200) {
      result = BrandResult.fromJson(response.body);
    } else {
      result = BrandResult.fromJson(
          {"status": "error", "message": "Server error !", "data": []});
    }

    return result;
  }

}
