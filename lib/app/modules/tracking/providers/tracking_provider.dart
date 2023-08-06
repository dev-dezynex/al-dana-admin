import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:al_dana_admin/app/data/constants/api_routes.dart';
import 'package:al_dana_admin/app/data/models/tracking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../../data/constants/common.dart';
import '../../../data/constants/keys.dart';

class TrackingProvider extends ChangeNotifier {
  Tracking? _tracking;
  bool _isLoading = false;
  bool _hasError = false;

  Tracking? get tracking => _tracking;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchTracking(
    String bookingId,
  ) async {
    try {
      _isLoading = true;
      final response = await http.get(
        Uri.parse("$apiGetTracking/$bookingId"),
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}',
        },
      );
      if (response.statusCode == 200) {
        _tracking = Tracking.fromJson(
          jsonDecode(response.body),
        );
        _hasError = false;
      } else {
        _tracking = null;
        _hasError = true;
      }
    } catch (_) {
      _tracking = null;
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> changeTrackingStatus(
    String trackingId,
    String trackingStatus,
  ) async {
    final body = <String, String>{
      "trackingStatus": trackingStatus,
    };
    final response = await http.put(
      Uri.parse("$apiEditTracking/$trackingId"),
      headers: <String, String>{
        'Authorization': 'Bearer ${storage.read(auth)}',
      },
      body: body,
    );
    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Status Changed Sucessfully',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Failed', 'Failed to change status',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> addBeforeOrAfterImage(
    String trackingId,
    String key,
    List<String> images,
  ) async {
    final body = <String, dynamic>{
      key: images,
    };

    final bodyJson = jsonEncode(body);
    log('body');
    log('$body');
    final response = await http.put(
      Uri.parse("$apiEditTracking/$trackingId"),
      headers: <String, String>{
        'Authorization': 'Bearer ${storage.read(auth)}',
        "Content-Type": "application/json",
      },
      encoding: Encoding.getByName('utf-8'),
      body: bodyJson,
    );
    log('json encode');
    log(jsonEncode(body));

    log('tracking id - $trackingId');
    if (response.statusCode == 200) {
      log(response.body.toString());
      Get.snackbar('Success', 'Images added Sucessfully.',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Failed', 'Failed to add image.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<List<String>> uploadImageFiles(
    List<File> imageFiles,
  ) async {
    const url = apiFileUpload;

    var request = http.MultipartRequest('POST', Uri.parse(url));
    try {
      for (var i = 0; i < imageFiles.length; i++) {
        var imageFile = imageFiles[i];
        request.files.add(
          http.MultipartFile(
            'image',
            File(imageFile.path).readAsBytes().asStream(),
            File(imageFile.path).lengthSync(),
            filename: '${DateTime.now().millisecondsSinceEpoch}_image$i.jpg',
          ),
        );
      }

      var response = await request.send();
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var parsedData = jsonDecode(responseData);
        List<String> uploadedImageStrings = [];
        for (var i = 0; i < imageFiles.length; i++) {
          String uploadedImageString = parsedData['data'][i];
          uploadedImageStrings.add(uploadedImageString);
        }
        return uploadedImageStrings;
      } else {
        log('Failed to upload');
        return [];
      }
    } catch (e) {
      log('Failed to upload due to $e');
      return [];
    }
  }
}
