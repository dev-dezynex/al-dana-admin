import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';
import '../controllers/time_slots_controller.dart';

class TimeSlotsView extends GetView<TimeSlotsController> {
  const TimeSlotsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        backgroundColor: bgColor1,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: const GoBack(),
          title: Text(
            'Time Slots',
            style:
                tsPoppins(size: 18, weight: FontWeight.w600, color: textDark80),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var startTime = await showTimePicker(
                context: context, initialTime: TimeOfDay.now());
            var endTime = await showTimePicker(
                context: context, initialTime: TimeOfDay.now());

            if (startTime != null && endTime != null) {
              String timeSlot =
                  '${startTime.format(context)} - ${endTime.format(context)}';

              controller.selectedTimeSlot.value.slotes.add(timeSlot);
              controller.selectedTimeSlot.refresh();
            }
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
                        color: bgColor27,
                        borderRadius: BorderRadius.circular(5)),
                    indicatorColor: bgColor36,
                    padding: EdgeInsets.zero,
                    isScrollable: true,
                    onTap: (value) {
                      controller.tabIndex.value = value;
                      controller.onSelectWeekDay(value);
                    },
                    tabs: List.generate(
                      controller.weekDays.length,
                      (index) => Tab(
                        child: Obx(
                          () => Text(
                            controller.weekDays[index],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: tsPoppins(
                                color: controller.tabIndex.value == index
                                    ? white
                                    : textDark80,
                                weight: FontWeight.w400),
                          ),
                        ),
                      ),
                    )),
              ),
              Expanded(
                child: Obx(
                  () {
                    return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 2.7 / 1,
                        ),
                        itemCount:
                            controller.selectedTimeSlot.value.slotes.length,
                        itemBuilder: (con, i) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            margin: const EdgeInsets.only(right: 0),
                            decoration: BoxDecoration(
                                color: textDark10,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${controller.selectedTimeSlot.value.slotes[i]}  ',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: tsPoppins(color: textDark80),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    myAlertDialog(
                                        title: 'Confirm',
                                        message:
                                            'Do you want to delete ${controller.selectedTimeSlot.value.slotes[i]} ?',
                                        onCancel: () {
                                          Get.back();
                                        },
                                        onSubmit: () {
                                          controller.deleteSlot(controller
                                              .selectedTimeSlot
                                              .value
                                              .slotes[i]);
                                        });
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: textDark40,
                                  ),
                                )
                              ],
                            ),
                          );
                        });
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
