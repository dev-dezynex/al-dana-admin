import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
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
  String _spareAmount = "";

  SpareList? get spareList => _spareList;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  bool get hasSpareSelected => _isSpareSelected;
  String get spareId => _spareId;
  String get spareAmount => _spareAmount;

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

  Future<void> addSpare(
    String bookingId,
    String spareId,
    String totalAmount,
    String spareAmount,
  ) async {
    final data = <String, dynamic>{
      "totalAmount": int.parse(totalAmount),
      "spareId": [
        {
          "spareId": spareId,
          "spareAmount": int.parse(spareAmount),
        },
      ]
    };
    final body = jsonEncode(data);
    final response = await http.put(
      Uri.parse("$apiEditBooking/$bookingId"),
      body: body,
      headers: <String, String>{
        'Authorization': 'Bearer ${storage.read(auth)}',
        "Content-Type": "application/json",
      },
      encoding: Encoding.getByName('utf-8'),
    );
    log('body');
    log(body.toString());
    log('body');
    log(response.body);
    log(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar(
        'Success',
        'Spare added',
      );
    } else {
      Get.snackbar(
        'Failed',
        'Spare not added',
        snackPosition: SnackPosition.BOTTOM,
      );
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

  void setSpareAmount(String newValue) {
    _spareAmount = newValue;
    notifyListeners();
  }
}
