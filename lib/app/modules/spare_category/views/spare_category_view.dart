import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';
import '../controllers/spare_category_controller.dart';

class SpareCategoryView extends GetView<SpareCategoryController> {
  const SpareCategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Spare Categories',
          style:
              tsPoppins(size: 18, weight: FontWeight.w600, color: textDark80),
        ),
        centerTitle: true,
        leading: const GoBack(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_SPARE_CATEGORY);
        },
        backgroundColor: primary,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Obx(
        () => ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            itemCount:
                controller.spareCategoryResult.value.spareCategoryList!.length,
            itemBuilder: (con, i) {
              return SpareCategoryTile(
                  onEdit: () {
                    Get.toNamed(Routes.ADD_SPARE_CATEGORY,
                        arguments: controller
                            .spareCategoryResult.value.spareCategoryList![i]);
                  },
                  onTap: () {
                        Get.toNamed(Routes.SPARE,
                        arguments: controller
                            .spareCategoryResult.value.spareCategoryList![i]);
                  },
                  spareCategory: controller
                      .spareCategoryResult.value.spareCategoryList![i]);
            }),
      ),
    );
  }
}
