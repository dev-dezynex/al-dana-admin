import 'dart:convert';

import 'package:al_dana_admin/app/modules/reports/models/job_report.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../data/constants/api_routes.dart';
import '../../../data/constants/common.dart';
import '../../../data/constants/keys.dart';

class JobReportProvider extends ChangeNotifier {
  JobReport? _jobReport;
  bool _isLoading = true;
  bool _hasError = false;

  JobReport? get jobReport => _jobReport;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchJobReport(
    String pageNo,
  ) async {
    try {
      final response = await http.get(
        Uri.parse("$apiGetJobReport?page=$pageNo&perPage=8"),
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}',
        },
      );
      if (response.statusCode == 200) {
        _jobReport = JobReport.fromJson(
          jsonDecode(response.body),
        );
      } else {
        _jobReport = null;
        _hasError = true;
      }
    } catch (error) {
      _jobReport = null;
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
