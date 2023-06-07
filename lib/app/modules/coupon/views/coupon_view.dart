import 'package:al_dana_admin/app/data/data.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/coupon_controller.dart';

class CouponView extends GetView<CouponController> {
  const CouponView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coupons'),
        centerTitle: true,
        leading: const GoBack(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_COUPON)!
              .then((value) => value ? controller.getDetails() : null);
        },
        backgroundColor: primary,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: controller.couponResult.value.couponList!.length,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  itemBuilder: (con, i) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: CouponCard(
                          backgroundColor: primary.withOpacity(.3),
                          curveAxis: Axis.vertical,
                          firstChild: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                    controller.couponResult.value.couponList![i]
                                                .couponType ==
                                            'Special'
                                        ? 'SPECIAL\nOFFER'
                                        : 'ONLY FOR \nYOU',
                                    maxLines: 2,
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                          secondChild: Container(
                            color: primary.withOpacity(.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                
                                Text(
                                    '${controller.couponResult.value.couponList![i].title}',
                                    textAlign: TextAlign.center,
                                    style: tsPoppins(
                                        color: white,
                                        weight: FontWeight.bold,
                                        size: 21)),
                                Text(
                                    'Service for ${controller.couponResult.value.couponList![i].amount} and ',
                                    textAlign: TextAlign.center,
                                    style: tsPoppins(
                                        color: Colors.black38,
                                        weight: FontWeight.normal,
                                        size: 15)),
                                Text(
                                    'Get ${controller.couponResult.value.couponList![i].discountAmount} OFF',
                                    textAlign: TextAlign.center,
                                    style: tsPoppins(
                                        color: Colors.black38,
                                        weight: FontWeight.bold,
                                        size: 18)),
                              ],
                            ),
                          )),
                    );
                  }),
        ),
      ),
    );
  }
}
