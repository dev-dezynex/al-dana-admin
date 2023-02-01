import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/branch_model.dart';

class BranchProvider extends GetConnect {
  Future<BranchResult> getDummyData() async {
    final file = await rootBundle.loadString('assets/json/branch.json');
    final data = await jsonDecode(file);
    BranchResult result = BranchResult.fromJson(data);
    return result;
  }
}
