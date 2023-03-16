import 'package:get/get.dart';

import '../data.dart';

class VariantProvider extends GetConnect {
//add carVariant id for update else insert
  Future<VariantResult> addOrUpdateVariant(
      {required Variant carVariant}) async {
    final VariantResult result;
    final Response<dynamic> response;
    if (carVariant.id.isEmpty) {
      response = await post(apiAddCarVariant, carVariant.toJson(),
          headers: Auth().requestHeaders);
      print('path $apiAddCarVariant');
    } else {
      response = await put(
          '$apiUpdateCarVariant/${carVariant.id}', carVariant.toJson(),
          headers: Auth().requestHeaders);
      print('path $apiUpdateCarVariant/${carVariant.id}');
    }
    print('body ${carVariant.toJson()}');
    print('response ${response.body}');

    result = VariantResult.fromJson(response.body);

    return result;
  }

  Future<VariantResult> getVariantList(String modelId) async {
    VariantResult result;
    Map<String, dynamic> qParams;
    if (modelId.isNotEmpty) {
      qParams = {'filter[carModelId]': modelId};
    } else {
      qParams = {};
    }
    final response = await get(apiListCarVariant,
        query: qParams, headers: Auth().requestHeaders);
    print('auth ${Auth().requestHeaders}');
    print('qparams $qParams');
    print('path $apiListCarVariant');
    print('response ${response.body}');
    if (response.statusCode == 200) {
      result = VariantResult.listFromJson(response.body);
    } else {
      result = VariantResult.listFromJson(
          {"status": "error", "message": "Server error !", "data": []});
    }

    return result;
  }

  Future<VariantResult> deleteVariant({required Variant carVariant}) async {
    VariantResult result;
    final response = await delete(
      '$apiDeleteCarVariant/${carVariant.id}',
      headers: Auth().requestHeaders,
    );

    print('path $apiDeleteCarVariant');
    print('response ${response.body}');
    if (response.statusCode == 200) {
      result = VariantResult.fromJson(response.body);
    } else {
      result = VariantResult.fromJson(
          {"status": "error", "message": "Server error !", "data": []});
    }

    return result;
  }
}
