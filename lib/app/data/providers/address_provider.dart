import 'package:get/get.dart';

import '../models/address_model.dart';

class AddressProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return AddressResult.fromJson(map);
      if (map is List)
        return map.map((item) => AddressResult.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<AddressResult?> getAddress(int id) async {
    final response = await get('address/$id');
    return response.body;
  }

  Future<Response<AddressResult>> postAddress(AddressResult address) async =>
      await post('address', address);
  Future<Response> deleteAddress(int id) async => await delete('address/$id');
}
