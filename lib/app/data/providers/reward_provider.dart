import 'package:get/get.dart';

import '../data.dart';
import '../models/reward_model.dart';

class RewardProvider extends GetConnect {
  Future<RewardResult> getRewards() async {
    Auth auth = Auth();
    Common common = Common();

    Map<String, dynamic> qParams = {
      'filter[customerId]': common.currentUser.id
    };
    final response = await get(apiListReward, headers: auth.requestHeaders);

    if (response.statusCode == 401) {
      auth.authFailed(response.body['message']);
    }
    return RewardResult.fromJson(response.body);
  }

  Future<RewardResult> updateRewards({required Reward reward}) async {
    Auth auth = Auth();

    final response = await put('$apiPutReward/${reward.sId}', reward.toPost(),
        headers: auth.requestHeaders);
    print('path $apiPutReward/${reward.sId}');
    print('body ${reward.toPost()}');
    if (response.statusCode == 401) {
      auth.authFailed(response.body['message']);
    }
    return RewardResult.fromJson(response.body);
  }
}
