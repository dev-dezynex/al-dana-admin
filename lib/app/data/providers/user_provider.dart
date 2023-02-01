import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class UserProvider extends GetConnect {
  Future<UserResult> getUserList() async {
    final file = await rootBundle.loadString('assets/json/user_list.json');
    final data = await jsonDecode(file);
    UserResult result = UserResult.listFromJson(data);
    return result;
  }
}
