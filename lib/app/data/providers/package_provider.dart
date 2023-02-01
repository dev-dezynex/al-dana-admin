import 'dart:convert';

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
}
