import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';
import '../controllers/service_list_controller.dart';

class ServiceListView extends GetView<ServiceListController> {
  const ServiceListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Service',
            style:
                tsPoppins(size: 18, weight: FontWeight.w600, color: textDark80),
          ),
          centerTitle: true,
          leading: const GoBack(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.ADD_SERVICE);
          },
          backgroundColor: primary,
          child: const Icon(
            Icons.add,
          ),
        ),
        body: SafeArea(
          child: Obx(
            () => GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Get.width ~/ 166,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1 / 1,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                itemCount: controller.serviceResult.value.serviceList.length,
                itemBuilder: (con, i) {
                  return ServiceTile(
                      isManage: true,
                      onEdit: () {
                        Get.toNamed(Routes.ADD_SERVICE,
                            arguments:
                                controller.serviceResult.value.serviceList[i]);
                      },
                      service: controller.serviceResult.value.serviceList[i]);
                }),
          ),
        ));
  }
}
