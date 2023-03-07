import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';
import '../controllers/banner_controller.dart';

class BannerView extends GetView<BannerController> {
  const BannerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor1,
        appBar: AppBar(
          leading: const GoBack(),
          centerTitle: true,
          title: Text(
            'Banners',
            style:
                tsPoppins(size: 18, weight: FontWeight.w600, color: textDark80),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(
              Routes.ADD_BANNER,
            )!
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
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    itemCount: controller.bannerResult.value.bannerList!.length,
                    itemBuilder: (con, i) {
                      return BannerTile(
                        onTap: () {
                          Get.toNamed(Routes.ADD_BANNER,
                                  arguments: controller
                                      .bannerResult.value.bannerList![i])!
                              .then((value) =>
                                  value ? controller.getDetails() : null);
                        },
                        imagePath:
                            controller.bannerResult.value.bannerList![i].image!,
                      );
                    }),
          ),
        ));
  }
}
