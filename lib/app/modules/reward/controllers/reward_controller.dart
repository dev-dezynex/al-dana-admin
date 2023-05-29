import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/data/models/reward_model.dart';
import 'package:al_dana_admin/app/data/providers/reward_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RewardController extends GetxController {
  var isLoading = false.obs;
  TextEditingController pointController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController billamountController = TextEditingController();
  var rewardResult = RewardResult().obs;
  @override
  void onInit() {
    super.onInit();
    getRewards();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updateReward() async {
    isLoading(true);
    final result = await RewardProvider().updateRewards(
        reward: rewardResult.value.reward!.copyWith(
            amount: double.parse(amountController.text),
            point: int.parse(pointController.text),
            redeemAmount: double.parse(billamountController.text)));
    if (result.status == 'success') {
      showSuccess(result.message!);
    } else {
      showError(result.message!);
    }
    isLoading(false);
  }

  void getRewards() async {
    isLoading(true);
    rewardResult.value = await RewardProvider().getRewards();
    rewardResult.refresh();
    fillView();
    isLoading(false);
  }

  void fillView() {
    pointController.text = rewardResult.value.reward!.point.toString();
    amountController.text = rewardResult.value.reward!.amount.toString();
    billamountController.text =
        rewardResult.value.reward!.redeemAmount.toString();
  }
}
