import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/spare_category_model.dart';

class SpareCategoryProvider extends GetConnect {
  Future<SpareCategoryResult> getDummyData() async {
    final file = await rootBundle.loadString('assets/json/spare_category.json');
    final data = await jsonDecode(file);
    SpareCategoryResult result = SpareCategoryResult.fromJson(data);
    return result;
  }
}
