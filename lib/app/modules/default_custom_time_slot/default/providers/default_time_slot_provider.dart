import 'package:flutter/material.dart';

class DefaultProvider extends ChangeNotifier {
  int _tabBarIndex = 0;
  String _branchId = '';
  String _categoryId = '';
  String _pickedDate = '';
  String _listDayId = '';
  bool _isBranchSelected = false;
  bool _isCategorySelected = false;
  bool _isTimeSlotSelected = false;
  bool _isListDaySelected = false;
  bool _isDatePicked = false;
  bool _isLoading = false;
  String _startTimeHour = '01';
  String _startTimeMinute = '00';
  String _endTimeHour = '01';
  String _endTimeMinute = '00';
  String _timsSlotId = '';

  int get tabBarIndex => _tabBarIndex;
  String get branchId => _branchId;
  String get categoryId => _categoryId;
  String get listDayId => _listDayId;
  String get pickedDate => _pickedDate;
  bool get isBranchSelected => _isBranchSelected;
  bool get isCategorySelected => _isCategorySelected;
  bool get isTimeSlotSelected => _isTimeSlotSelected;
  bool get isListDaySelected => _isListDaySelected;
  bool get isDatePicked => _isDatePicked;
  bool get isLoading => _isLoading;
  String get startTimeHour => _startTimeHour;
  String get startTimeMinute => _startTimeMinute;
  String get endTimeHour => _endTimeHour;
  String get endTimeMinute => _endTimeMinute;
  String get startTime => '$_startTimeHour:$_startTimeMinute';
  String get endTime => '$_endTimeHour:$_endTimeMinute';
  String get timeSlotId => _timsSlotId;

  set startTimeHour(String newValue) {
    _startTimeHour = newValue;
    notifyListeners();
  }

  set startTimeMinute(String newValue) {
    _startTimeMinute = newValue;
    notifyListeners();
  }

  set endTimeHour(String newValue) {
    _endTimeHour = newValue;
    notifyListeners();
  }

  set endTimeMinute(String newValue) {
    _endTimeMinute = newValue;
    notifyListeners();
  }

  void setTabBarIndex(int newValue) {
    _tabBarIndex = newValue;
    notifyListeners();
  }

  void setBranchId(String newValue) {
    _branchId = newValue;
    notifyListeners();
  }

  void setCategoryId(String newValue) {
    _categoryId = newValue;
    notifyListeners();
  }

  void setListDayId(String newValue) {
    _listDayId = newValue;
    notifyListeners();
  }

  void setPickedDate(String newValue) {
    _pickedDate = newValue;
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

  void setIsTimeSlotSelected(bool newValue) {
    _isTimeSlotSelected = newValue;
    notifyListeners();
  }

  void setIsListDaySelected(bool newValue) {
    _isListDaySelected = newValue;
    notifyListeners();
  }

  void setIsLoading(bool newValue) {
    _isLoading = newValue;
    notifyListeners();
  }

  void setTimeSlotId(String newValue) {
    _timsSlotId = newValue;
    notifyListeners();
  }

  void clearAll() {
    _tabBarIndex = 0;
    _branchId = '';
    _categoryId = '';
    _pickedDate = '';
    _listDayId = '';
    _isBranchSelected = false;
    _isCategorySelected = false;
    _isTimeSlotSelected = false;
    _isListDaySelected = false;
    _isDatePicked = false;
    _isLoading = false;
    _startTimeHour = '01';
    _startTimeMinute = '00';
    _endTimeHour = '01';
    _endTimeMinute = '00';
    _timsSlotId = '';
    notifyListeners();
  }
}
