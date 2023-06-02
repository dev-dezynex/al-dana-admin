import 'dart:convert';
import 'package:al_dana_admin/app/data/models/default_time_slot.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../constants/api_routes.dart';
import '../constants/common.dart';
import '../constants/keys.dart';

class DefaultTimeSlotProvider {
  Future<DefaultTimeSlot> fetchTimeSlot(
    String branchId,
    String categoryId,
    String date,
  ) async {
    final response = await http.get(
      Uri.parse(
          "${apiGetDefaultTimeSlot}filter[branchId]=$branchId&filter[categoryId]=$categoryId&filter[date]=$date"),
      headers: <String, String>{
        'Authorization': 'Bearer ${storage.read(auth)}',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return DefaultTimeSlot.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception("Failed to load default time slot");
    }
  }
}
