import 'package:get/get.dart';

import '../models/variant_model.dart';

class VariantProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return VariantResult.fromJson(map);
      if (map is List) {
        return map.map((item) => VariantResult.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<VariantResult?> getVariant(int id) async {
    final response = await get('variant/$id');
    return response.body;
  }

  Future<Response<VariantResult>> postVariant(VariantResult variant) async =>
      await post('variant', variant);
  Future<Response> deleteVariant(int id) async => await delete('variant/$id');
}
