import 'dart:convert';
import 'dart:developer';

import 'package:al_dana_admin/app/modules/reports/models/subscription_report.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../data/constants/api_routes.dart';
import '../../../data/constants/common.dart';
import '../../../data/constants/keys.dart';

class SubscriptionReportProvider extends ChangeNotifier {
  SubscriptionReport? _subscriptionReport;
  bool _isLoading = true;
  bool _hasError = false;

  SubscriptionReport? get subscriptionReport => _subscriptionReport;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchSubscriptionReport(
    String pageNo,
  ) async {
    try {
      log('subscription called');
      _isLoading = true;
      final response = await http.get(
        Uri.parse("$apiGetSubscriptionReport?page=$pageNo&perPage=8"),
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}',
        },
      );
      if (response.statusCode == 200) {
        _subscriptionReport = SubscriptionReport.fromJson(
          jsonDecode(response.body),
        );
      } else {
        _subscriptionReport = null;
        _hasError = true;
      }
    } catch (error) {
      _subscriptionReport = null;
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
