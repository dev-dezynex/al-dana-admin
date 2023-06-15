import 'dart:convert';
import 'dart:developer';
import 'package:al_dana_admin/app/data/models/default_time_slot.dart';
import 'package:flutter/material.dart';

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
    String dayId,
  ) async {
    log(branchId);
    log(categoryId);
    log(dayId);
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http.get(
        Uri.parse(
            "${apiGetDefaultTimeSlotAdmin}filter[branchId]=$branchId&filter[categoryId]=$categoryId&filter[dayId]=$dayId"),
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

  Future<void> addDefaultTimeSlot(
    String branchId,
    String dayId,
    String categoryId,
    String timeSlotId,
  ) async {
    final body = <String, dynamic>{
      'branchId': branchId,
      'dayId': dayId,
      'categoryId': categoryId,
      'timeSlotId': timeSlotId,
    };
    try {
      final response = await http.post(
        Uri.parse(apiAddDefaultTimeSlot),
        body: body,
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}'
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        _isLoading = true;
        notifyListeners();
      } else {
        log('Failed to submit');
      }
    } catch (e) {
      log(e.toString());
      log('failed with exception');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteDefaultTimeSlot(
    String defaultTimeSlotId,
    String timeSlotId,
  ) async {
    final body = <String, dynamic>{
      "timeSlotId": timeSlotId,
    };
    try {
      log(defaultTimeSlotId);
      log(timeSlotId);
      _isLoading = true;
      notifyListeners();
      final response = await http.put(
        Uri.parse('$apiUpdateDefaultTimeSlot/$defaultTimeSlotId'),
        body: body,
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}'
        },
      );
      if (response.statusCode == 200) {
        log(response.body);
      } else {
        log('Failed to submit due to status code error ${response.statusCode}');
      }
    } catch (error) {
      log('Failed due to $error');
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
