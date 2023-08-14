import 'package:al_dana_admin/app/data/models/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            style: tsPoppins(
                                                color: white, size: 20),
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
                                            style: tsPoppins(
                                                color: white, size: 20),
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
              body: TabBarView(
                  children: List.generate(
                      4,
                      (index) => Obx(
                          () => viewTabs(index, controller.bookingResult)))),
            ),
          ),
        ));
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
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: Get.height * .02),
        itemCount: bookings.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (con, i) {
          return BookingTile2(
            booking: bookings[i],
            controller: controller,
          );
        });
  }
}
