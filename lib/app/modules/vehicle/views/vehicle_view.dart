import 'package:al_dana_admin/app/modules/vehicle/views/colors_view.dart';
import 'package:al_dana_admin/app/modules/vehicle/views/year_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';
import '../controllers/vehicle_controller.dart';
import 'brand_view.dart';

class VehicleView extends GetView<VehicleController> {
  const VehicleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return WillPopScope(
    //   onWillPop: () async {
    //     if (controller.pageIndex.value > 0) {
    //       controller.pageIndex.value = 0;
    //       return false;
    //     } else {
    //       Get.back();
    //       return true;
    //     }
    //   },
    //   child: Scaffold(
    //       backgroundColor: bgColor1,
    //       appBar: AppBar(
    //         title: Obx(
    //           () => Text(
    //             controller.pageTitle.value,
    //             style: tsPoppins(
    //                 size: 18, weight: FontWeight.w600, color: textDark80),
    //           ),
    //         ),
    //         centerTitle: true,
    //         leading: GoBack(
    //           onPressed: () {
    //             if (controller.pageIndex.value > 0) {
    //               controller.pageIndex.value = 0;
    //             } else {
    //               Get.back();
    //             }
    //           },
    //         ),
    //       ),
    //       body: Obx(() {
    //         switch (controller.pageIndex.value) {
    //           case 1:
    //             return const BrandView();
    //           case 2:
    //             return const ColorsView();
    //           case 3:
    //             return const YearView();
    //           default:
    //             return manageView();
    //         }
    //       })),
    // );

    return Scaffold(
      backgroundColor: bgColor1,
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.pageTitle.value,
            style:
                tsPoppins(size: 18, weight: FontWeight.w600, color: textDark80),
          ),
        ),
        centerTitle: true,
        leading: const GoBack(),
      ),
      body:const BrandView(),
    );
  }

  manageView() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    controller.pageIndex.value = 1;
                    controller.pageTitle.value = 'Manage Brands';
                  },
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: Get.height * .15,
                        maxHeight: Get.height * .2,
                        minWidth: Get.width * .3,
                        maxWidth: Get.width * .4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: bgColor29,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "Manage\nBrands",
                      textAlign: TextAlign.center,
                      style: tsPoppins(
                          color: white, size: 18, weight: FontWeight.w600),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.pageIndex.value = 2;
                    controller.pageTitle.value = 'Manage Colors';
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: bgColor30,
                        borderRadius: BorderRadius.circular(8)),
                    constraints: BoxConstraints(
                        minHeight: Get.height * .15,
                        maxHeight: Get.height * .2,
                        minWidth: Get.width * .3,
                        maxWidth: Get.width * .4),
                    alignment: Alignment.center,
                    child: Text(
                      "Manage\nColors",
                      textAlign: TextAlign.center,
                      style: tsPoppins(
                          color: white, size: 18, weight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    controller.pageIndex.value = 3;
                    controller.pageTitle.value = 'Manage Year';
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: bgColor31,
                        borderRadius: BorderRadius.circular(8)),
                    constraints: BoxConstraints(
                        minHeight: Get.height * .15,
                        maxHeight: Get.height * .2,
                        minWidth: Get.width * .3,
                        maxWidth: Get.width * .4),
                    alignment: Alignment.center,
                    child: Text(
                      "Manage\nYear",
                      textAlign: TextAlign.center,
                      style: tsPoppins(
                          color: white, size: 18, weight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8)),
                  constraints: BoxConstraints(
                      minHeight: Get.height * .15,
                      maxHeight: Get.height * .2,
                      minWidth: Get.width * .3,
                      maxWidth: Get.width * .4),
                  alignment: Alignment.center,
                  child: Text(
                    "       ",
                    style: tsPoppins(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
