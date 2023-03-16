import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../data.dart';

class CategoryProvider extends GetConnect {
  Future<CategoryResult> getDummyData() async {
    final file = await rootBundle.loadString('assets/json/category.json');
    final data = await jsonDecode(file);
    CategoryResult result = CategoryResult.fromJson(data);
    return result;
  }

//pass the category id to update else insert
  Future<CategoryResult> addOrUpdateCategory(
      {required Category category}) async {
    final CategoryResult result;
    final Response<dynamic> response;
    if (category.id.isEmpty) {
      response = await post(apiAddCategory, category.toJson(),
          headers: Auth().requestHeaders);
      print('path $apiAddCategory');
    } else {
      response = await put(
          '$apiUpdateCategory/${category.id}', category.toJson(),
          headers: Auth().requestHeaders);
      print('path $apiUpdateCategory/${category.id}');
    }
    print('body ${category.toJson()}');
    print('response ${response.body}');

    result = CategoryResult.fromJson(response.body);

    return result;
  }

  Future<CategoryResult> getCategories() async {
    CategoryResult result;
    Map<String, dynamic> qParams = {};
    final response = await get(
      apiListCategory,
      query: qParams,
      headers: Auth().requestHeaders,
    );
    print('qparams $qParams');
    print('path $apiListCategory');
    print('response ${response.body}');
    if (response.statusCode == 401) {
      Auth().authFailed(response.body['message']);
    }
    result = CategoryResult.listFromJson(response.body);
    return result;
  }

  Future<CategoryResult> deleteCategory({required Category category}) async {
    CategoryResult result;
    final response = await delete(
      '$apiDeleteCategory/${category.id}',
      headers: Auth().requestHeaders,
    );
    print('path $apiDeleteCategory');
    print('response ${response.body}');
    result = CategoryResult.fromJson(response.body);

    return result;
  }
}
