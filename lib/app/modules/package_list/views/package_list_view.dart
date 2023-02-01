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
            Get.toNamed(Routes.ADD_PACKAGE);
          },
          backgroundColor: primary,
          child: const Icon(
            Icons.add,
          ),
        ),
        body: SafeArea(
          child: Obx(
            () => ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                itemCount: controller.packageResult.value.packageList!.length,
                itemBuilder: (con, i) {
                  return PackageTile(
                    isManage: true,
                    onEdit: () {
                      Get.toNamed(Routes.ADD_PACKAGE,
                          arguments:
                              controller.packageResult.value.packageList![i]);
                    },
                    package: controller.packageResult.value.packageList![i],
                  );
                }),
          ),
        ));
  }
}
