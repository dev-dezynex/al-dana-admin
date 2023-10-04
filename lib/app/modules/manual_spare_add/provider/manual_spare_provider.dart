import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../data/constants/api_routes.dart';
import '../../../data/constants/common.dart';
import '../../../data/constants/keys.dart';
import '../models/spare_list.dart';
import 'package:http/http.dart' as http;

class ManualSpareListProvider extends ChangeNotifier {
  SpareList? _spareList;
  bool _isLoading = true;
  bool _hasError = false;
  bool _isSpareSelected = false;
  String _spareId = "";

  SpareList? get spareList => _spareList;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  bool get hasSpareSelected => _isSpareSelected;
  String get spareId => _spareId;

  Future<void> getSpareList(
    String spareCategoryId,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$apiListActiveSpare?filter[spareCategoryId]=$spareCategoryId'),
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}',
        },
      );
      if (response.statusCode == 200) {
        _spareList = SpareList.fromJson(
          jsonDecode(response.body),
        );
      } else {
        _spareList = null;
        _hasError = true;
      }
    } catch (error) {
      _spareList = null;
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setIsSpareSelected(bool newValue) {
    _isSpareSelected = newValue;
    notifyListeners();
  }

  void setSpareId(String newValue) {
    _spareId = newValue;
    notifyListeners();
  }
}
