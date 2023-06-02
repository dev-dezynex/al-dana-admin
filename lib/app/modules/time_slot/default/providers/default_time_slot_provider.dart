import 'package:flutter/material.dart';

class DefaultProvider extends ChangeNotifier {
  String _branchId = '';
  String _categoryId = '';
  bool _isBranchSelected = false;
  bool _isCategorySelected = false;
  bool _isDatePicked = false;
  bool _isLoading = false;

  String get branchId => _branchId;
  String get categoryId => _categoryId;
  bool get isBranchSelected => _isBranchSelected;
  bool get isCategorySelected => _isCategorySelected;
  bool get isDatePicked => _isDatePicked;
  bool get isLoading => _isLoading;

  void setBranchId(String newValue) {
    _branchId = newValue;
    notifyListeners();
  }

  void setCategoryId(String newValue) {
    _categoryId = newValue;
    notifyListeners();
  }

  void setIsDatePicked(bool newValue) {
    _isDatePicked = newValue;
    notifyListeners();
  }

  void setIsBranchSelected(bool newValue) {
    _isBranchSelected = newValue;
    notifyListeners();
  }

  void setIsCategorySelected(bool newValue) {
    _isCategorySelected = newValue;
    notifyListeners();
  }

  void setIsLoading(bool newValue) {
    _isLoading = newValue;
    notifyListeners();
  }
}
