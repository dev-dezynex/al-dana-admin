import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../constants/constants.dart';
import '../models/spare_model.dart';

class SpareProvider extends GetConnect {
  Future<SpareResult> listActiveSpare({String? spareCategoryId}) async {
    SpareResult result;
    Map<String, dynamic> params = {};
    if (spareCategoryId != null) {
      params['filter[spareCategoryId]'] = spareCategoryId;
    }
    final response = await get(apiListActiveSpare,
        headers: Auth().requestHeaders, query: params);
    print('path $apiListActiveSpare');
    print('params ${jsonEncode(params)}');
    print('auth ${Auth().requestHeaders}');
    print('response ${response.body}');
    result = SpareResult.listFromJson(response.body);

    return result;
  }

  Future<SpareResult> addSpare({required Spare spare}) async {
    SpareResult result;

    final response =
        await post(apiAddSpare, spare.toJson(), headers: Auth().requestHeaders);
    print('path $apiAddSpare');
    log('body ${jsonEncode(spare.toJson())}');
    print('auth ${Auth().requestHeaders}');
    print('response ${response.body}');
    result = SpareResult.fromJson(response.body);

    return result;
  }

  Future<SpareResult> updateSpare({required Spare spare}) async {
    SpareResult result;

    final response = await put('$apiUpdateSpare/${spare.id}', spare.toJson(),
        headers: Auth().requestHeaders);
    print('path $apiUpdateSpare');
    log('body ${jsonEncode(spare.toJson())}');
    print('auth ${Auth().requestHeaders}');
    print('response ${response.body}');
    result = SpareResult.fromJson(response.body);

    return result;
  }

  Future<SpareResult> deleteSpare({required String spareId}) async {
    SpareResult result;

    final response = await delete('$apiDeleteSpare/$spareId',
        headers: Auth().requestHeaders);
    print('path $apiDeleteSpare');
    print('auth ${Auth().requestHeaders}');
    print('response ${response.body}');
    result = SpareResult.fromJson(response.body);

    return result;
  }
}
