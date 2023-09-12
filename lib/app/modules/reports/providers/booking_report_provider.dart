import 'dart:convert';
import 'package:al_dana_admin/app/modules/reports/models/booking_report.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../data/constants/api_routes.dart';
import '../../../data/constants/common.dart';
import '../../../data/constants/keys.dart';

class BookingReportProvider extends ChangeNotifier {
  BookingReport? _bookingReport;
  bool _isLoading = true;
  bool _hasError = false;

  BookingReport? get bookingReport => _bookingReport;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchBookingReport(
    String pageNo,
  ) async {
    try {
      final response = await http.get(
        Uri.parse("$apiGetBookingReport?page=$pageNo&perPage=8"),
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}',
        },
      );
      if (response.statusCode == 200) {
        _bookingReport = BookingReport.fromJson(
          jsonDecode(response.body),
        );
      } else {
        _bookingReport = null;
        _hasError = true;
      }
    } catch (error) {
      _bookingReport = null;
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
