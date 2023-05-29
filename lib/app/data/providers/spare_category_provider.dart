import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../models/spare_category_model.dart';

class SpareCategoryProvider extends GetConnect {
  Future<SpareCategoryResult> deleteSpareCategory(
      {required String spareCategoryId}) async {
    SpareCategoryResult result;
    final response = await delete(
      '$apiDeleteSpareCategory/$spareCategoryId',
      headers: Auth().requestHeaders,
    );
    print('path $apiDeleteSpareCategory/$spareCategoryId');
    print('auth ${Auth().requestHeaders}');
    print('response ${response.body}');
    result = SpareCategoryResult.fromJson(response.body);

    return result;
  }

  Future<SpareCategoryResult> getSpareCategory(
      {required String spareCategoryId}) async {
    SpareCategoryResult result;
    final response = await get(
      '$apiReadSpare/$spareCategoryId',
      headers: Auth().requestHeaders,
    );
    print('path $apiReadSpare');
    print('auth ${Auth().requestHeaders}');
    print('response ${response.body}');
    result = SpareCategoryResult.fromJson(response.body);

    return result;
  }

  Future<SpareCategoryResult> listActiveSpareCategory() async {
    SpareCategoryResult result;
    final response = await get(
      apiListActiveSpareCategory,
      headers: Auth().requestHeaders,
    );
    print('path $apiListActiveSpareCategory');
    print('auth ${Auth().requestHeaders}');
    print('response ${response.body}');
    result = SpareCategoryResult.listFromJson(response.body);

    return result;
  }

  Future<SpareCategoryResult> addSpareCategory(
      SpareCategory spareCategory) async {
    SpareCategoryResult result;
    final response = await post(
      apiAddSpareCategory,
      spareCategory.toPost(),
      headers: Auth().requestHeaders,
    );
    print('path $apiAddSpareCategory');
    print('auth ${Auth().requestHeaders}');
    print('body ${spareCategory.toPost()}');
    print('response ${response.body}');
    result = SpareCategoryResult.fromJson(response.body);

    return result;
  }
  Future<SpareCategoryResult> updateSpareCategory(
      SpareCategory spareCategory) async {
    SpareCategoryResult result;
    final response = await put(
      '$apiUpdateSpareCategory/${spareCategory.id}',
      spareCategory.toPost(),
      headers: Auth().requestHeaders,
    );
    print('path $apiUpdateSpareCategory');
    print('auth ${Auth().requestHeaders}');
    print('body ${spareCategory.toPost()}');
    print('response ${response.body}');
    result = SpareCategoryResult.fromJson(response.body);

    return result;
  }
}
