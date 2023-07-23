import 'dart:convert';
import 'dart:developer';

import 'package:al_dana_admin/app/data/constants/api_routes.dart';
import 'package:al_dana_admin/app/data/models/vat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/constants/common.dart';
import '../../../data/constants/keys.dart';

class VATProvider extends ChangeNotifier {
  VatList? _vatList;

  bool _isLoading = false;
  bool _hasError = false;

  VatList? get vatList => _vatList;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchVAT() async {
    try {
      _isLoading = true;
      final response = await http.get(
        Uri.parse(apiGetVat),
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}'
        },
      );
      if (response.statusCode == 200) {
        log(response.body.toString());
        _vatList = VatList.fromJson(jsonDecode(response.body));
        _hasError = false;
      }
    } catch (error) {
      _vatList = null;
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateVat(
    String vatId,
    String vatPercentage,
  ) async {
    final body = <String, String>{
      "percentage": vatPercentage,
    };
    final response = await http.put(
      Uri.parse("$apiEditVat/$vatId"),
      headers: <String, String>{
        'Authorization': 'Bearer ${storage.read(auth)}'
      },
      body: body,
    );
    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Updated VAT %');
      final data = jsonDecode(response.body);

      log('Update call$data');
    } else {
      Get.snackbar('Failed', 'Update of VAT % failed');
    }
  }
}
