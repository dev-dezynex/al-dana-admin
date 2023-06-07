import 'dart:convert';

import 'package:al_dana_admin/app/data/models/list_days.dart';
import 'package:http/http.dart' as http;

import '../constants/api_routes.dart';
import '../constants/common.dart';
import '../constants/keys.dart';

class ListDaysProvider {
  static Future<ListDays> fetchListDays() async {
    final response = await http.get(
      Uri.parse(apiListDays),
      headers: <String, String>{
        'Authorization': 'Bearer ${storage.read(auth)}',
      },
    );
    print(apiListDays);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return ListDays.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load list days");
    }
  }
}
