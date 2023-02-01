import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/year_model.dart';

class YearProvider extends GetConnect {
  Future<YearResult> getDummyData() async {
    final file = await rootBundle.loadString('assets/json/year.json');
    final data = await jsonDecode(file);
    YearResult result = YearResult.fromJson(data);
    return result;
  }
}
