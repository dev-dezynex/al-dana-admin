import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';
import '../controllers/package_list_controller.dart';

class PackageListView extends GetView<PackageListController> {
  const PackageListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Packages',
            style:
                tsPoppins(size: 18, weight: FontWeight.w600, color: textDark80),
          ),
          centerTitle: true,
          leading: const GoBack(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.isEdit.value = false;
            Get.toNamed(Routes.ADD_PACKAGE)!
                .then((value) => value ? controller.getPackages() : null);
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
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    itemCount:
                        controller.packageResult.value.packageList!.length,
                    itemBuilder: (con, i) {
                      return PackageTile(
                        isManage: true,
                        onEdit: () {
                          controller.isEdit.value = true;
                          Get.toNamed(Routes.ADD_PACKAGE,
                                  arguments: controller
                                      .packageResult.value.packageList![i])!
                              .then((value) =>
                                  value ? controller.getPackages() : null);
                        },
                        package: controller.packageResult.value.packageList![i],
                      );
                    }),
          ),
        ));
  }
}
