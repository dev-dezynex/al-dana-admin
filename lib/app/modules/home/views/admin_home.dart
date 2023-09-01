import 'dart:developer';

import 'package:al_dana_admin/app/data/models/booking_model.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/providers/default_custom_time_slot_provider.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/utils/branch_drop_down.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/utils/select_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../data/data.dart';
import '../controllers/home_controller.dart';

class AdminHomeView extends GetView<HomeController> {
  const AdminHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor1,
      body: DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (con, innerscroll) {
              return <Widget>[
                SliverAppBar(
                  titleSpacing: 0.0,
                  toolbarHeight: 0.0,
                  pinned: true,
                  snap: false,
                  floating: false,
                  expandedHeight: 180,
                  automaticallyImplyLeading: false,
                  backgroundColor: white,
                  centerTitle: true,
                  bottom: PreferredSize(
                      preferredSize: Size(Get.width, 60),
                      child: SizedBox(
                        width: Get.width,
                        child: TabBar(
                          isScrollable: true,
                          indicatorColor: accent60,
                          onTap: (index) {
                            controller.adminTabIndex.value = index;
                          },
                          tabs: [
                            Tab(
                              child: Text(
                                'Pending',
                                style: tsPoppins(size: 14, color: textDark80),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Confirmed',
                                style: tsPoppins(size: 14, color: textDark80),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Assigned',
                                style: tsPoppins(size: 14, color: textDark80),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Cancelled',
                                style: tsPoppins(size: 14, color: textDark80),
                              ),
                            ),
                          ],
                        ),
                      )),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      width: Get.width,
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: Get.width * .45,
                                  padding: EdgeInsets.only(
                                    top: Get.height * .03,
                                    bottom: Get.height * .03,
                                  ),
                                  decoration: BoxDecoration(
                                      color: bgColor5,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Total Booking',
                                        style:
                                            tsPoppins(color: white, size: 14),
                                      ),
                                      SizedBox(
                                        height: Get.height * .01,
                                      ),
                                      Obx(
                                        () => Text(
                                          (controller.bookingResult.value.data
                                                      ?.length ??
                                                  0)
                                              .toString(),
                                          style:
                                              tsPoppins(color: white, size: 20),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: Get.width * .45,
                                  padding: EdgeInsets.only(
                                    top: Get.height * .03,
                                    bottom: Get.height * .03,
                                  ),
                                  decoration: BoxDecoration(
                                      color: bgColor11,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Total Completed',
                                        style:
                                            tsPoppins(color: white, size: 14),
                                      ),
                                      SizedBox(
                                        height: Get.height * .01,
                                      ),
                                      Obx(
                                        () => Text(
                                          (controller.bookingResult.value.data
                                                      ?.where((element) =>
                                                          element
                                                              .approvalStatus!
                                                              .toLowerCase() ==
                                                          'assigned')
                                                      .toList()
                                                      .length ??
                                                  0)
                                              .toString(),
                                          style:
                                              tsPoppins(color: white, size: 20),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Get.height * .01 + 50),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: TabBarView(
                    children: List.generate(
                      4,
                      (index) => Obx(
                        () => viewTabs(index, controller.bookingResult),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 2,
                  top: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: IconButton(
                      onPressed: () {
                        Provider.of<DefaultCustomProvider>(context,
                                listen: false)
                            .clearAll();

                        showDialog(
                          context: context,
                          builder: (context) => const FilterMenu(),
                        );
                      },
                      icon: const Icon(Icons.filter_list),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: primary.withOpacity(0.8),
        onPressed: () async {
          final DateTime? dateTime = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now(),
          );
          if (dateTime != null) {
            controller.dateTime.value =
                "${dateTime.year}-${dateTime.month}-${dateTime.day}";
            log("${dateTime.year}-${dateTime.month}-${dateTime.day}");
            controller.refreshfilterBooking();
          }
        },
        child: const Icon(Icons.filter_alt),
      ),
    );
  }

  viewTabs(int index, bookingResult) {
    List bookings = <Data>[];

    if (controller.bookingResult.value.data != null &&
        controller.bookingResult.value.data!.isNotEmpty) {
      switch (index) {
        case 1:
          bookings = controller.bookingResult.value.data!
              .where((element) =>
                  element.approvalStatus!.toLowerCase() == 'confirmed')
              .toList()
              .reversed
              .toList();
          break;
        case 2:
          bookings = controller.bookingResult.value.data!
              .where((element) =>
                  element.approvalStatus!.toLowerCase() == 'assigned')
              .toList()
              .reversed
              .toList();
          break;
        case 3:
          bookings = controller.bookingResult.value.data!
              .where((element) =>
                  element.approvalStatus!.toLowerCase() == 'cancelled')
              .toList()
              .reversed
              .toList();
          break;
        default:
          bookings = controller.bookingResult.value.data!
              .where((element) =>
                  element.approvalStatus!.toLowerCase() == 'pending')
              .toList()
              .reversed
              .toList();
          break;
      }
    }
    return RefreshIndicator(
      onRefresh: () async {
        controller.dateTime.value = "";
        controller.filterBranchId.value = '';
        await Future.delayed(
          const Duration(seconds: 1),
        );
        controller.getDetails();
      },
      child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: Get.height * .02),
          itemCount: bookings.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (con, i) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: BookingTile2(
                booking: bookings[i],
                controller: controller,
              ),
            );
          }),
    );
  }
}

class FilterMenu extends StatelessWidget {
  const FilterMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    Common common = Common();
    return AlertDialog(
      title: const Text('Filter by'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Close',
            style: TextStyle(color: primary),
          ),
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Date'),
            onTap: () {
              controller.dateTime.value = '';
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Select Date'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SelectDateForBooking(),
                    ],
                  ),
                  actions: [
                    if (Provider.of<DefaultCustomProvider>(context)
                            .pickedDate !=
                        '')
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          controller.dateTime.value =
                              Provider.of<DefaultCustomProvider>(context,
                                      listen: false)
                                  .pickedDate;
                          controller.getDetails();
                        },
                        child: const Text(
                          'Filter',
                          style: TextStyle(color: primary),
                        ),
                      ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: primary),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          if (common.currentUser.scope == "superAdmin")
            ListTile(
              title: const Text('Branch ID'),
              onTap: () {
                controller.filterBranchId.value = '';
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Select Branch'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        BranchDropDown(),
                      ],
                    ),
                    actions: [
                      if (Provider.of<DefaultCustomProvider>(context)
                              .branchId !=
                          "")
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              controller.filterBranchId.value =
                                  Provider.of<DefaultCustomProvider>(context,
                                          listen: false)
                                      .branchId;
                              log('after filter');
                              log(controller.filterBranchId.value);
                              controller.getDetails();
                            },
                            child: const Text(
                              'Filter',
                              style: TextStyle(color: primary),
                            )),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Close',
                          style: TextStyle(color: primary),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
