import 'dart:convert';

import 'package:al_dana_admin/app/data/data.dart';
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

  verifyUser({required String username, required String password}) async {
    final UserResult result;
    var body = {"email": username, "password": password};
    final response = await post(apiSignin, body);

    print('body $body');
    print('path $apiSignin');
    print('response ${response.body}');
    if (response.statusCode == 200) {
      result = UserResult.fromJson(response.body);
      var authValue = response.body['data']['token'];
      storage.write(auth, authValue);
    } else {
      result =
          UserResult.fromJson({"status": "error", "message": "Server error !"});
    }

    return result;
  }
}
