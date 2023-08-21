import 'dart:convert';

import 'package:al_dana_admin/app/data/constants/api_routes.dart';
import 'package:al_dana_admin/app/modules/reports/models/invoice_report.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../data/constants/common.dart';
import '../../../data/constants/keys.dart';

class InvoiceReportProvider extends ChangeNotifier {
  InvoiceReport? _invoiceReport;

  bool _isLoading = false;
  bool _hasError = false;

  InvoiceReport? get invoiceReport => _invoiceReport;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchInvoiceReport(
    String pageNo,
  ) async {
    try {
      _isLoading = true;
      final response = await http.get(
        Uri.parse("$apiGetInvoiceReport?page=$pageNo&perPage=8"),
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}',
        },
      );
      if (response.statusCode == 200) {
        _invoiceReport = InvoiceReport.fromJson(
          jsonDecode(response.body),
        );
      } else {
        _invoiceReport = null;
        _hasError = true;
      }
    } catch (error) {
      _invoiceReport = null;
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
