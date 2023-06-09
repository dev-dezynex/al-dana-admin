import 'package:flutter/material.dart';

class TimeSlotProvider extends ChangeNotifier {
  String _startTimeHour = '01';
  String _startTimeMinute = '00';
  String _endTimeHour = '01';
  String _endTimeMinute = '00';
  int _maxBooking = 0;

  String get startTimeHour => _startTimeHour;
  String get startTimeMinute => _startTimeMinute;
  String get endTimeHour => _endTimeHour;
  String get endTimeMinute => _endTimeMinute;
  int get maxBooking => _maxBooking;

  set startTimeHour(String value) {
    _startTimeHour = value;
    notifyListeners();
  }

  set startTimeMinute(String value) {
    _startTimeMinute = value;
    notifyListeners();
  }

  set endTimeHour(String value) {
    _endTimeHour = value;
    notifyListeners();
  }

  set endTimeMinute(String value) {
    _endTimeMinute = value;
    notifyListeners();
  }

  set maxBooking(int value) {
    _maxBooking = value;
    notifyListeners();
  }
}
