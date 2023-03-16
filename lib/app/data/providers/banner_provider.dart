import 'package:get/get.dart';

import '../data.dart';

class BannerProvider extends GetConnect {
  //add banner id for update else insert
  Future<BannerResult> addOrUpdateBanner({required BannerModel banner}) async {
    final BannerResult result;
    final Response<dynamic> response;
    if (banner.sId!.isEmpty) {
      response = await post(apiAddBanner, banner.toJson(),
          headers: Auth().requestHeaders);
      print('path $apiAddBanner');
    } else {
      response = await put('$apiUpdateBanner/${banner.sId}', banner.toJson(),
          headers: Auth().requestHeaders);
      print('path $apiUpdateBanner/${banner.sId}');
    }
    print('body ${banner.toJson()}');
    print('response ${response.body}');

    result = BannerResult.fromJson(response.body);

    return result;
  }

  Future<BannerResult> getBanneres() async {
    BannerResult result;
    Map<String, dynamic> qParams = {'filter[status]': 'true'};
    final response =
        await get(apiListBanner, query: qParams, headers: Auth().requestHeaders);
    print('auth ${Auth().requestHeaders}');
    print('qparams $qParams');
    print('path $apiListBanner');
    print('response ${response.body}');
    if (response.statusCode == 200) {
      result = BannerResult.listFromJson(response.body);
    } else {
      result = BannerResult.listFromJson(
          {"status": "error", "message": "Server error !", "data": []});
    }

    return result;
  }

  Future<BannerResult> deleteBanner({required BannerModel banner}) async {
    BannerResult result;
    final response = await delete(
      '$apiDeleteBanner/${banner.sId}',
      headers: Auth().requestHeaders,
    );

    print('path $apiDeleteBanner');
    print('response ${response.body}');
    if (response.statusCode == 200) {
      result = BannerResult.fromJson(response.body);
    } else {
      result = BannerResult.fromJson(
          {"status": "error", "message": "Server error !", "data": []});
    }

    return result;
  }
}
