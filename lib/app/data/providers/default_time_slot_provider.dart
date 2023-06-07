import 'dart:convert';
import 'package:al_dana_admin/app/data/models/default_time_slot.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../constants/api_routes.dart';
import '../constants/common.dart';
import '../constants/keys.dart';

class DefaultTimeSlotProvider extends ChangeNotifier {
  DefaultTimeSlot? _defaultTimeSlot;
  bool _isLoading = false;
  bool _hasError = false;

  DefaultTimeSlot? get defaultTimeSlot => _defaultTimeSlot;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  Future<void> fetchTimeSlot(
    String branchId,
    String categoryId,
    String date,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http.get(
        Uri.parse(
            "${apiGetDefaultTimeSlot}filter[branchId]=$branchId&filter[categoryId]=$categoryId&filter[date]=$date"),
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}',
        },
      );
      if (response.statusCode == 200) {
        _defaultTimeSlot = DefaultTimeSlot.fromJson(jsonDecode(response.body));
        _hasError = false;
      } else {
        _defaultTimeSlot = null;
        _hasError = true;
      }
    } catch (error) {
      _defaultTimeSlot = null;
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearDefaultTimeslots() {
    _defaultTimeSlot = null;
    _hasError = false;
    _isLoading = false;
    notifyListeners();
  }
}
