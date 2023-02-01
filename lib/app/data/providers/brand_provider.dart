import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/brand_model.dart';

class BrandProvider extends GetConnect {
  Future<BrandResult> getDummyData() async {
    final file = await rootBundle.loadString('assets/json/brand.json');
    final data = await jsonDecode(file);
    
    BrandResult result = BrandResult.fromJson(data);
    return result;
  }
}
