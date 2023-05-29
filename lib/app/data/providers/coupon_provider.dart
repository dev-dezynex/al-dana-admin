import 'package:get/get.dart';

import '../data.dart';

class CouponProvider extends GetConnect {
  Future<CouponResult> getCoupons() async {
    Auth auth = Auth();
    Common common = Common();

    Map<String, dynamic> qParams = {
      'filter[customerId]': common.currentUser.id
    };
    final response = await get(apiListCoupon, headers: auth.requestHeaders);

    if (response.statusCode == 401) {
      auth.authFailed(response.body['message']);
    }
    return CouponResult.listFromJson(response.body);
  }

  Future<CouponResult> postCoupons({required Coupon coupon}) async {
    Auth auth = Auth();

    final response = await post(apipostCoupon, coupon.toPost(),
        headers: auth.requestHeaders);

    if (response.statusCode == 401) {
      auth.authFailed(response.body['message']);
    }
    return CouponResult.fromJson(response.body);
  }
}
