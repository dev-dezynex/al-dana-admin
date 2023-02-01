import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/category_model.dart';

class CategoryProvider extends GetConnect {
  Future<CategoryResult> getDummyData() async {
    final file = await rootBundle.loadString('assets/json/category.json');
    final data = await jsonDecode(file);
    CategoryResult result = CategoryResult.fromJson(data);
    return result;
  }
}
