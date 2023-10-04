import 'dart:convert';
import 'dart:developer';
import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/modules/manual_spare_add/models/spare_category_list_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ManualSpareCategoryProvider extends ChangeNotifier {
  SpareCategoryList? _spareCategoryResult;
  bool _isLoading = true;
  bool _hasError = false;
  bool _isSpareCategorySelected = false;
  String _spareCategoryId = "";

  SpareCategoryList? get spareCategoryResult => _spareCategoryResult;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  bool get isSpareCategorySelected => _isSpareCategorySelected;
  String get spareCategoryId => _spareCategoryId;

  Future<void> getListSpareCategory() async {
    try {
      final response = await http.get(
        Uri.parse(apiListActiveSpareCategory),
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}',
        },
      );
      if (response.statusCode == 200) {
        _spareCategoryResult = SpareCategoryList.fromJson(
          jsonDecode(response.body),
        );
      } else {
        _spareCategoryResult = null;
        _hasError = true;
      }
    } catch (error) {
      _spareCategoryResult = null;
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setIsSpareCateogrySelected(bool newValue) {
    _isSpareCategorySelected = newValue;
    notifyListeners();
  }

  void setSpareCategoryId(String newValue) {
    _spareCategoryId = newValue;
    notifyListeners();
  }
}
