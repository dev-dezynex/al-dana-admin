import 'dart:convert';

import 'package:al_dana_admin/app/data/constants/api_routes.dart';
import 'package:al_dana_admin/app/modules/reports/models/package_report.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../data/constants/common.dart';
import '../../../data/constants/keys.dart';

class PackageReportProvider extends ChangeNotifier {
  PackageReport? _packageReport;
  bool _isLoading = true;
  bool _hasError = false;

  PackageReport? get packageReport => _packageReport;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchPackageReport(
    String pageNo,
  ) async {
    try {
      _isLoading = true;
      final response = await http.get(
          Uri.parse("$apiGetPackageReport?page=$pageNo&perPage=8"),
          headers: <String, String>{
            'Authorization': 'Bearer ${storage.read(auth)}',
          });
      if (response.statusCode == 200) {
        _packageReport = PackageReport.fromJson(
          jsonDecode(response.body),
        );
      } else {
        _packageReport = null;
        _hasError = true;
      }
    } catch (error) {
      _packageReport = null;
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
