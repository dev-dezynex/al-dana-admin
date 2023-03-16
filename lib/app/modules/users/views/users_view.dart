import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';
import '../controllers/users_controller.dart';

class UsersView extends GetView<UsersController> {
  const UsersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: bgColor1,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: const GoBack(),
          title: Text(
            'Users',
            style:
                tsPoppins(size: 18, weight: FontWeight.w600, color: textDark80),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.ADD_USERS)!
                .then((value) => value ? controller.getDetails() : null);
          },
          backgroundColor: primary,
          child: const Icon(
            Icons.add,
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                decoration: BoxDecoration(
                    color: bgColor36, borderRadius: BorderRadius.circular(5)),
                child: TabBar(
                  unselectedLabelColor: bgColor36,
                  indicator: BoxDecoration(
                      color: bgColor27, borderRadius: BorderRadius.circular(5)),
                  indicatorColor: bgColor36,
                  padding: EdgeInsets.zero,
                  onTap: (value) {
                    controller.tabIndex.value = value;
                  },
                  tabs: [
                    Tab(
                      child: Obx(
                        () => Text(
                          'Admin',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: tsPoppins(
                              color: controller.tabIndex.value == 0
                                  ? white
                                  : textDark80,
                              weight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Tab(
                      child: Obx(
                        () => Text(
                          'Managers',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: tsPoppins(
                              color: controller.tabIndex.value == 1
                                  ? white
                                  : textDark80,
                              weight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Tab(
                      child: Obx(
                        () => Text(
                          'Technician',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: tsPoppins(
                              color: controller.tabIndex.value == 2
                                  ? white
                                  : textDark80,
                              weight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Tab(
                      child: Obx(
                        () => Text(
                          'Customer',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: tsPoppins(
                              color: controller.tabIndex.value == 3
                                  ? white
                                  : textDark80,
                              weight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                  () {
                    switch (controller.tabIndex.value) {
                      case 1:
                        return ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            itemCount: controller.managerList.length,
                            itemBuilder: (con, i) {
                              return UserTile(
                                onEdit: () {
                                  Get.toNamed(Routes.ADD_USERS,
                                      arguments: controller.managerList[i])!
                                      .then((value) => value
                                          ? controller.getDetails()
                                          : null);
                                },
                                user: controller.managerList[i],
                              );
                            });
                      case 2:
                        return ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            itemCount: controller.technicianList.length,
                            itemBuilder: (con, i) {
                              return UserTile(
                                onEdit: () {
                                  Get.toNamed(Routes.ADD_USERS,
                                          arguments:
                                              controller.technicianList[i])!
                                      .then((value) => value
                                          ? controller.getDetails()
                                          : null);
                                },
                                user: controller.technicianList[i],
                              );
                            });
                      case 3:
                        return ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            itemCount: controller.customerList.length,
                            itemBuilder: (con, i) {
                              return UserTile(
                                onEdit: () {
                                  Get.toNamed(Routes.ADD_USERS,
                                      arguments: controller.customerList[i])!
                                      .then((value) => value
                                          ? controller.getDetails()
                                          : null);
                                },
                                user: controller.customerList[i],
                              );
                            });
                      default:
                        return ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            itemCount: controller.adminList.length,
                            itemBuilder: (con, i) {
                              return UserTile(
                                onEdit: () {
                                  Get.toNamed(Routes.ADD_USERS,
                                      arguments: controller.adminList[i])!
                                      .then((value) => value
                                          ? controller.getDetails()
                                          : null);
                                },
                                user: controller.adminList[i],
                              );
                            });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
