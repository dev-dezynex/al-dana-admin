import 'dart:convert';
import 'dart:developer';

import 'package:al_dana_admin/app/data/constants/api_routes.dart';
import 'package:al_dana_admin/app/data/models/time_slot_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../constants/common.dart';
import '../constants/keys.dart';

class TimeSlotApiProvider extends ChangeNotifier {
  TimeSlots? _timeSlots;
  bool _isLoading = false;
  bool _hasError = false;

  TimeSlots? get timeSlots => _timeSlots;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchTimeSlots() async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http
          .get(Uri.parse(apiListActiveTimeSlot), headers: <String, String>{
        'Authorization': 'Bearer ${storage.read(auth)}',
      });
      if (response.statusCode == 200) {
        _timeSlots = TimeSlots.fromJson(jsonDecode(response.body));
        _hasError = false;
      } else {
        _timeSlots = null;
        _hasError = true;
      }
    } catch (error) {
      _timeSlots = null;
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTimeSlots(
    String startTime,
    String endTime,
    String maxBooking,
  ) async {
    final body = <String, dynamic>{
      'startTime': startTime,
      'endTime': endTime,
      'maxBooking': maxBooking,
    };
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http.post(Uri.parse(apiAddTimeSlot),
          body: body,
          headers: <String, String>{
            'Authorization': 'Bearer ${storage.read(auth)}'
          });

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

  Future<void> updateTimeSlot(
    String timeSlotId,
    String startingTime,
    String endTime,
    String maxBooking,
  ) async {
    final body = <String, dynamic>{
      'startTime': startingTime,
      'endTime': endTime,
      'maxBooking': maxBooking,
    };

    try {
      _isLoading = true;
      notifyListeners();
      final response = await http.put(
          Uri.parse('$apiUpdateTimeSlot/$timeSlotId'),
          body: body,
          headers: <String, String>{
            'Authorization': 'Bearer ${storage.read(auth)}'
          });
      log('path-');
      log('$apiUpdateTimeSlot/$timeSlotId');
      log('body-');
      log(body.toString());
      log(response.statusCode.toString());
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

  Future<void> deleteTimeSlot(
    String timeSlotId,
  ) async {
    final body = <String, dynamic>{
      'deletable': 'true',
    };

    try {
      _isLoading = true;
      notifyListeners();
      final response = await http.put(
          Uri.parse('$apiUpdateTimeSlot/$timeSlotId'),
          body: body,
          headers: <String, String>{
            'Authorization': 'Bearer ${storage.read(auth)}'
          });
      log('path-');
      log('$apiUpdateTimeSlot/$timeSlotId');
      log('body-');
      log(body.toString());
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        _isLoading = true;
        notifyListeners();
      } else {
        log('Failed to submit due to status code error ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      log('failed with exception');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearTimeSlots() {
    _timeSlots = null;
    _isLoading = false;
    _hasError = false;
    notifyListeners();
  }
}
