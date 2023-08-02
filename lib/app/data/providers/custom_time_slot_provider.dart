import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:al_dana_admin/app/data/models/custom_time_slot.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/api_routes.dart';
import '../constants/common.dart';
import '../constants/keys.dart';

class CustomTimeSlotProvider extends ChangeNotifier {
  CustomTimeSlot? _customTimeSlot;
  bool _isLoading = false;
  bool _hasError = false;

  CustomTimeSlot? get customTimeSlot => _customTimeSlot;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchCustomTimeSlot(
    String branchId,
    String categoryId,
    String date,
  ) async {
    try {
      log(branchId);
      log(categoryId);
      log(date);
      _isLoading = true;
      notifyListeners();
      final response = await http.get(
        Uri.parse(
            "${apiGetCustomTimeSlot}filter[branchId]=$branchId&filter[categoryId]=$categoryId&filter[date]=$date"),
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}',
        },
      );
      if (response.statusCode == 200) {
        log(response.body);
        _customTimeSlot = CustomTimeSlot.fromJson(
          jsonDecode(response.body),
        );
      } else {
        _customTimeSlot = null;
        _hasError = true;
      }
    } catch (error) {
      _customTimeSlot = null;
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addCustomTimeSlot(
    String branchId,
    String date,
    String categoryId,
    String timeSlotId,
  ) async {
    final body = <String, dynamic>{
      'branchId': branchId,
      'date': date,
      'categoryId': categoryId,
      'timeSlotId': timeSlotId,
    };
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http.post(
        Uri.parse(apiAddCustomTimeSlot),
        body: body,
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}'
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Time slot added successfully');
        _isLoading = true;
        notifyListeners();
      } else {
        Get.snackbar('Failed', 'Failed to add time slot');
        log('Failed to submit');
      }
    } catch (e) {
      Get.snackbar('Failed', 'Failed to add time slot');
      log(e.toString());
      log('failed with exception');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteCustomTimeSlot(
    String customTimeSlotId,
    String timeSlotId,
  ) async {
    final body = <String, dynamic>{
      "timeSlotId": timeSlotId,
    };
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http.put(
        Uri.parse('$apiUpdateCustomTimeSlot/$customTimeSlotId'),
        body: body,
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}'
        },
      );
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Time slot deleted successfully');
        log(response.body);
      } else {
        Get.snackbar('Failed', 'Failed to delete time slot');
        log('Failed to submit due to status code error ${response.statusCode}');
      }
    } catch (error) {
      Get.snackbar('Failed', 'Failed to delete time slot');
      log('Failed due to $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearCustomTimeslots() {
    _customTimeSlot = null;
    _hasError = false;
    _isLoading = false;
    notifyListeners();
  }
}
