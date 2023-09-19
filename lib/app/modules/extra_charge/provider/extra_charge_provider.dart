import 'dart:convert';
import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/modules/extra_charge/models/extra_charge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ExtraChargeProvider extends ChangeNotifier {
  ExtraCharge? _extraCharge;
  bool _isLoading = true;
  bool _hasError = false;

  ExtraCharge? get extraCharge => _extraCharge;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchExtraCharge() async {
    try {
      _isLoading = true;
      final response = await http.get(
        Uri.parse(apiGetExtraCharge),
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}',
        },
      );
      if (response.statusCode == 200) {
        _extraCharge = ExtraCharge.fromJson(
          jsonDecode(response.body),
        );
      } else {
        _extraCharge = null;
        _hasError = true;
      }
    } catch (error) {
      _extraCharge = null;
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addExtraCharge(
    String serviceModeId,
    String amount,
    String minimumDistance,
  ) async {
    final body = <String, dynamic>{
      "serviceModeId": serviceModeId,
      "amount": amount,
      "minimumDistance": minimumDistance,
    };

    final response = await http.post(Uri.parse(apiAddExtraCharge),
        body: body,
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}'
        });

    final jsonBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Get.snackbar('Success', jsonBody['message'],
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Failed', jsonBody['message'],
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> editExtraCharge(
    String extraChargeId,
    String serviceModeId,
    String amount,
    String minimumDistance,
  ) async {
    final body = <String, dynamic>{
      "serviceModeId": serviceModeId,
      "amount": amount,
      "minimumDistance": minimumDistance,
    };
    final response = await http.put(
      Uri.parse("$apiEditExtraCharge/$extraChargeId"),
      body: body,
      headers: <String, String>{
        'Authorization': 'Bearer ${storage.read(auth)}'
      },
    );

    final jsonBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Get.snackbar('Success', jsonBody['message'],
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Failed', jsonBody['message'],
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> deleteExtraCharge(
    String extraChargeId,
  ) async {
    final response = await http.delete(
      Uri.parse("$apiDeleteExtraCharge/$extraChargeId"),
      headers: <String, String>{
        'Authorization': 'Bearer ${storage.read(auth)}'
      },
    );
    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Deleted', snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Failed', 'Failed to Delete',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
