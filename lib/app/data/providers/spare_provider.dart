import 'package:get/get.dart';

import '../models/spare_model.dart';

class SpareProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return SpareResult.fromJson(map);
      if (map is List) {
        return map.map((item) => SpareResult.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<SpareResult?> getSpare(int id) async {
    final response = await get('spare/$id');
    return response.body;
  }

  Future<Response<SpareResult>> postSpare(SpareResult spare) async =>
      await post('spare', spare);
  Future<Response> deleteSpare(int id) async => await delete('spare/$id');
}
