import 'package:get/get.dart';

import '../data.dart';

class CarModelProvider extends GetConnect {
//add carModel id for update else insert
  Future<CarModelResult> addOrUpdateCarModel(
      {required CarModel carModel}) async {
    final CarModelResult result;
    final Response<dynamic> response;
    if (carModel.sId!.isEmpty) {
      response = await post(apiAddCarModel, carModel.toJson(),
          headers: Auth().requestHeaders);
      print('path $apiAddCarModel');
    } else {
      response = await put(
          '$apiUpdateCarModel/${carModel.sId}', carModel.toJson(),
          headers: Auth().requestHeaders);
      print('path $apiUpdateCarModel/${carModel.sId}');
    }
    print('body ${carModel.toJson()}');
    print('response ${response.body}');

    result = CarModelResult.fromJson(response.body);

    return result;
  }
Future<CarModelResult> getCarModelList(String brandId)async{
    CarModelResult result;
    Map<String, dynamic> qParams = {
      'filter[status]': 'true',
      'filter[carBrandId]': brandId
    };
    final response = await get(apiListCarModel,
        query: qParams, headers: Auth().requestHeaders);
    print('auth ${Auth().requestHeaders}');
    print('qparams $qParams');
    print('path $apiListCarModel');
    print('response ${response.body}');
    if (response.statusCode == 200) {
      result = CarModelResult.listFromJson(response.body);
    } else {
      result = CarModelResult.listFromJson(
          {"status": "error", "message": "Server error !", "data": []});
    }

    return result;
  }

  Future<CarModelResult> deleteCarModel({required CarModel carModel}) async {
    CarModelResult result;
    final response = await delete(
      '$apiDeleteCarModel/${carModel.sId}',
      headers: Auth().requestHeaders,
    );

    print('path $apiDeleteCarModel');
    print('response ${response.body}');
    if (response.statusCode == 200) {
      result = CarModelResult.fromJson(response.body);
    } else {
      result = CarModelResult.fromJson(
          {"status": "error", "message": "Server error !", "data": []});
    }

    return result;
  }
}
