import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../data.dart';

class BranchProvider extends GetConnect {
  Future<BranchResult> getDummyData() async {
    final file = await rootBundle.loadString('assets/json/branch.json');
    final data = await jsonDecode(file);
    BranchResult result = BranchResult.listFromJson(data);
    return result;
  }

//add branch id for update else insert
  Future<BranchResult> addOrUpdateBranch({required Branch branch}) async {
    final BranchResult result;
    final Response<dynamic> response;
    if (branch.id.isEmpty) {
      response = await post(apiAddBranch, branch.toPost(),
          headers: Auth().requestHeaders);
      print('path $apiAddBranch');
    } else {
      response = await put('$apiUpdateBranch/${branch.id}', branch.toPost(),
          headers: Auth().requestHeaders);
      print('path $apiUpdateBranch/${branch.id}');
    }
    print('body ${branch.toJson()}');
    print('response ${response.body}');

    result = BranchResult.fromJson(response.body);

    return result;
  }

  // Future<BranchResult> updateBranch(
  //     {required Branch branch, File? file}) async {
  //   final BranchResult result;
  //   final formData;
  //   if (file != null) {
  //     String fileName = file.path.split('/').last;
  //     formData = FormData({
  //       'name': branch.name,
  //       'landMark': branch.location,
  //       'latitude': branch.latitude,
  //       'longitude': branch.longitude,
  //       'rating': branch.rating,
  //       'image': MultipartFile(file, filename: fileName),
  //     });
  //   } else {
  //     formData = FormData({
  //       'name': branch.name,
  //       'landMark': branch.location,
  //       'latitude': branch.latitude,
  //       'longitude': branch.longitude,
  //       'rating': branch.rating,
  //     });
  //   }
  //   final response = await put('$apiUpdateBranch/${branch.id}', formData,
  //       contentType: 'multipart/form-data', headers: Auth().requestHeaders);
  //   print('formdata $formData');
  //   print('path $apiUpdateBranch/${branch.id}');
  //   print('response ${response.body}');
  //   if (response.statusCode == 200) {
  //     result = BranchResult.fromJson(response.body);
  //   } else {
  //     result = BranchResult.fromJson({
  //       "status": "error",
  //       "message": "Server error !",
  //     });
  //   }
  //   return result;
  // }

  Future<BranchResult> getBranches() async {
    BranchResult result;
    Map<String, dynamic> qParams = {'filter[status]': 'true'};
    final response =
        await get(apiListBranch, query: qParams, headers: Auth().requestHeaders);
    print('auth ${Auth().requestHeaders}');
    print('qparams $qParams');
    print('path $apiListBranch');
    print('response ${response.body}');
    if (response.statusCode == 200) {
      result = BranchResult.listFromJson(response.body);
    } else {
      result = BranchResult.listFromJson(
          {"status": "error", "message": "Server error !", "data": []});
    }

    return result;
  }

  Future<BranchResult> deleteBranch({required Branch branch}) async {
    BranchResult result;
    final response = await delete(
      '$apiDeleteBranch/${branch.id}',
      headers: Auth().requestHeaders,
    );

    print('path $apiDeleteBranch');
    print('response ${response.body}');
    if (response.statusCode == 200) {
      result = BranchResult.fromJson(response.body);
    } else {
      result = BranchResult.fromJson(
          {"status": "error", "message": "Server error !", "data": []});
    }

    return result;
  }
}
