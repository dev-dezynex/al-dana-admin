import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';
import '../controllers/service_mode_controller.dart';

class ServiceModeView extends GetView<ServiceModeController> {
  const ServiceModeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Service Modes',
            style:
                tsPoppins(size: 18, weight: FontWeight.w600, color: textDark80),
          ),
          centerTitle: true,
          leading: const GoBack(),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Get.toNamed(Routes.ADD_SERVICE_MODE);
        //   },
        //   backgroundColor: primary,
        //   child: const Icon(
        //     Icons.add,
        //   ),
        // ),
        body: SafeArea(
          child: Obx(
            () => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    itemCount: controller
                        .serviceModeResult.value.serviceModeList!.length,
                    itemBuilder: (con, i) {
                      return ServiceModeTile(
                        isManage: true,
                        onTap: () {
                          // Get.toNamed(Routes.ADD_SERVICE_MODE,
                          //     arguments: controller
                          //         .serviceModeResult.value.serviceModeList![i]);
                        },
                        mode: controller
                            .serviceModeResult.value.serviceModeList![i],
                      );
                    }),
          ),
        ));
  }
}
