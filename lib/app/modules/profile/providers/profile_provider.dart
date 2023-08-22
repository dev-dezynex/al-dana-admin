import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:al_dana_admin/app/data/constants/api_routes.dart';
import 'package:al_dana_admin/app/data/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/constants/common.dart';
import '../../../data/constants/keys.dart';

class ProfileProvider extends ChangeNotifier {
  Profile? _profile;
  bool _isLoading = true;
  bool _hasError = false;

  Profile? get profile => _profile;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchProfile() async {
    _isLoading = true;

    try {
      final response = await http.get(
        Uri.parse(apiGetProfile),
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}',
        },
      );
      if (response.statusCode == 200) {
        log(response.body.toString());
        _profile = Profile.fromJson(
          jsonDecode(response.body),
        );
      }
    } catch (error) {
      _profile = null;
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile(
    String profileId,
    String key,
    String value,
  ) async {
    final body = <String, dynamic>{
      key: value,
    };

    final response = await http.put(Uri.parse('$apiUpdateProfile/$profileId'),
        body: body,
        headers: <String, String>{
          'Authorization': 'Bearer ${storage.read(auth)}'
        });
    log('$apiUpdateProfile/$profileId');
    log(body.toString());
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      log('Update response');
      log(responseJson.toString());
      final message = responseJson["message"].toString();
      final status = responseJson["status"].toString();
      Get.snackbar(status.toUpperCase(), message);
    } else {
      Get.snackbar("Failed", 'Failed to upload');
    }
  }

  Future<String> uploadImageFile(
    File imageFile,
  ) async {
    const url = apiFileUpload;

    var request = http.MultipartRequest('POST', Uri.parse(url));

    List<int> imageBytes = await imageFile.readAsBytes();
    var imageField = http.MultipartFile.fromBytes('image', imageBytes,
        filename: 'image.jpg');
    request.files.add(imageField);

    try {
      var response = await request.send();
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var parsedData = jsonDecode(responseData);
        String uploadedImageString = parsedData['data'][0];
        log('Uploaded image string');
        log(uploadedImageString);
        return uploadedImageString;
      } else {
        log('Failed to upload');
        return '';
      }
    } catch (e) {
      log('Failed to upload due to $e');
      return '';
    }
  }
}
