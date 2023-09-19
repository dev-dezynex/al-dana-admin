import 'dart:convert';

import 'package:al_dana_admin/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ServiceModeListProvider extends ChangeNotifier {
  ServiceModeResult? _serviceModeResult;
  bool _isLoading = true;
  bool _hasError = false;
  String _serviceModeId = "";

  ServiceModeResult? get serviceModeResult => _serviceModeResult;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get serviceModeId => _serviceModeId;

  Future<void> fetchServiceModeList() async {
    try {
      _isLoading = true;
      final response = await http.get(
        Uri.parse(apiListServiceMode),
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}',
        },
      );
      if (response.statusCode == 200) {
        _serviceModeResult = ServiceModeResult.fromJson(
          jsonDecode(response.body),
        );
      } else {
        _serviceModeResult = null;
        _hasError = true;
      }
    } catch (error) {
      _serviceModeResult = null;
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setServiceModeId(String newValue) {
    _serviceModeId = newValue;
    notifyListeners();
  }
}
