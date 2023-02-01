import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';
import '../controllers/spare_controller.dart';

class SpareView extends GetView<SpareController> {
  const SpareView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Spares',
          style:
              tsPoppins(size: 18, weight: FontWeight.w600, color: textDark80),
        ),
        centerTitle: true,
        leading: const GoBack(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_SPARE);
        },
        backgroundColor: primary,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Obx(
        () => ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            itemCount: controller.selectedSpareCategory.value.spareList!.length,
            itemBuilder: (con, i) {
              return SpareTile(
                  onEdit: () {
                    Get.toNamed(Routes.ADD_SPARE,
                        arguments: controller
                            .selectedSpareCategory.value.spareList![i]);
                  },
                  spare: controller.selectedSpareCategory.value.spareList![i]);
            }),
      ),
    );
  }
}
