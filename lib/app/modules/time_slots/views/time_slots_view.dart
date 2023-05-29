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
      length: 2,
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
            //Get.toNamed(Routes.add)
            // var startTime = await showTimePicker(
            //     context: context, initialTime: TimeOfDay.now());
            // var endTime = await showTimePicker(
            //     context: context, initialTime: TimeOfDay.now());

            // if (startTime != null && endTime != null) {
            //   String timeSlot =
            //       '${startTime.format(context)} - ${endTime.format(context)}';

            //   controller.selectedDefaultTimeSlot.value.slotes.add(timeSlot);
            //   controller.selectedDefaultTimeSlot.refresh();
            // }
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
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 0),
                decoration: BoxDecoration(
                    color: bgColor36, borderRadius: BorderRadius.circular(5)),
                child: TabBar(
                    unselectedLabelColor: bgColor36,
                    indicator: BoxDecoration(
                        color: bgColor27,
                        borderRadius: BorderRadius.circular(5)),
                    indicatorColor: bgColor36,
                    padding: EdgeInsets.zero,
                    isScrollable: false,
                    onTap: (value) {
                      controller.tabIndex.value = value;
                    },
                    tabs: List.generate(
                      controller.mainTabs.length,
                      (index) => Tab(
                        child: Obx(
                          () => Text(
                            controller.mainTabs[index],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: tsPoppins(
                                size: 14,
                                color: controller.tabIndex.value == index
                                    ? white
                                    : textDark80,
                                weight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )),
              ),
              Expanded(
                child: Obx(
                  () {
                    switch (controller.tabIndex.value) {
                      case 1:
                        return customTimeSlot();
                      default:
                        return defaultTimeSlot();
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

  Widget defaultTimeSlot() {
    return Column(
      children: [
        const SizedBox(
          height: 35,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: InputFormDecoration.outLinedInputTextDecoration(
                  borderSide: const BorderSide(color: Colors.transparent),
                  labelText: "Select day",
                  fillColor: textDark10,
                  filled: true,
                  labelStyle: tsPoppins(
                      size: 14, weight: FontWeight.w400, color: textDark40)),
              value: controller.selectedDay.value,
              items: controller.weekDays.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: tsPoppins(color: textDark80, size: 14)),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectedDay.value = value!;
                controller.onSelectWeekDay(value);
              }),
        ),
        const SizedBox(
          height: 15,
        ),
        GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.7 / 1,
            ),
            itemCount: controller.selectedDefaultTimeSlot.value.slotes.length,
            itemBuilder: (con, i) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                margin: const EdgeInsets.only(right: 0),
                decoration: BoxDecoration(
                    color: textDark10, borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${controller.selectedDefaultTimeSlot.value.slotes[i]}  ',
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
                                'Do you want to delete ${controller.selectedDefaultTimeSlot.value.slotes[i]} ?',
                            onCancel: () {
                              Get.back();
                            },
                            onSubmit: () {
                              controller.deleteDefaultSlot(controller
                                  .selectedDefaultTimeSlot.value.slotes[i].id);
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
            }),
      ],
    );
  }

  Widget customTimeSlot() {
    return Column(
      children: [
        const SizedBox(
          height: 35,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
              controller: controller.dateController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Select date";
                } else {
                  return null;
                }
              },
              onTap: () {
                controller.chooseDate();
              },
              readOnly: true,
              textAlignVertical: TextAlignVertical.center,
              style: tsPoppins(
                  size: 14, weight: FontWeight.w400, color: textDark80),
              decoration: InputFormDecoration.outLinedInputTextDecoration(
                borderSide: const BorderSide(color: textDark20, width: 1),
                filled: true,
                fillColor: white,
                contentPadding: const EdgeInsets.only(left: 20),
                suffixIcon: const Padding(
                    padding: EdgeInsets.all(15), // add padding to adjust icon
                    child: Icon(
                      Icons.calendar_month,
                      color: textDark40,
                    )),
                labelText: "Select Date",
                labelStyle: tsPoppins(
                    size: 14, weight: FontWeight.w400, color: textColor02),
              )),
        ),
        const SizedBox(
          height: 15,
        ),
        GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.7 / 1,
            ),
            itemCount: controller.selectedCustomTimeSlot.value.slotes.length,
            itemBuilder: (con, i) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                margin: const EdgeInsets.only(right: 0),
                decoration: BoxDecoration(
                    color: textDark10, borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${controller.selectedCustomTimeSlot.value.slotes[i]}  ',
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
                                'Do you want to delete ${controller.selectedCustomTimeSlot.value.slotes[i]} ?',
                            onCancel: () {
                              Get.back();
                            },
                            onSubmit: () {
                              controller.deleteCustomSlot(controller
                                  .selectedCustomTimeSlot.value.slotes[i].id);
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
            }),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
