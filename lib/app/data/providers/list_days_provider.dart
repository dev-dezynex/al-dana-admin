import 'dart:convert';

import 'package:al_dana_admin/app/data/models/list_days.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/api_routes.dart';
import '../constants/common.dart';
import '../constants/keys.dart';

class ListDaysProvider extends ChangeNotifier {
  ListDays? _listDays;
  ListDays? get listDays => _listDays;
  bool _isLoading = true;
  bool _hasError = false;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchListDays() async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http.get(
        Uri.parse(apiListDays),
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}',
        },
      );

      if (response.statusCode == 200) {
        _hasError = false;
        _listDays = ListDays.fromJson(jsonDecode(response.body));
      } else {
        _hasError = true;
        _listDays = null;
      }
    } catch (error) {
      _listDays = null;
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
