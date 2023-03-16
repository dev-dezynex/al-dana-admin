import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';
import '../controllers/vehicle_controller.dart';

class YearView extends GetView<VehicleController> {
  const YearView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor1,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Select Year"),
                  content: SizedBox(
                    // Need to use container to add size constraint.
                    width: 300,
                    height: 300,
                    child: YearPicker(
                      firstDate: DateTime(DateTime.now().year - 100, 1),
                      lastDate: DateTime(DateTime.now().year, 1),
                      initialDate: DateTime.now(),
                      // save the selected date to _selectedDate DateTime variable.
                      // It's used to set the previous selected date when
                      // re-showing the dialog.
                      selectedDate: controller.selectedYear.value,
                      onChanged: (DateTime dateTime) {
                        // close the dialog when year is selected.
                        Navigator.pop(context);

                        // Do something with the dateTime selected.
                        // Remember that you need to use dateTime.year to get the year
                        controller.addToYearList(dateTime);
                      },
                    ),
                  ),
                );
              },
            );
          },
          backgroundColor: primary,
          child: const Icon(
            Icons.add,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(15),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1 / 1,
                      ),
                      itemCount: controller.yearList.length,
                      itemBuilder: (con, i) {
                        return InkWell(
                          onTap: () {
                                    myAlertDialog(
                                title: 'Confirm',
                                message:
                                    'Do you want to delete ${controller.yearList[i].name} ?',
                                onCancel: () {
                                  Get.back();
                                },
                                onSubmit: () {
                                  controller
                                      .deleteYear(controller.yearList[i]);
                                });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              controller.yearList[i].name!,
                              style: tsPoppins(
                                  weight: FontWeight.w400,
                                  size: 14,
                                  color: textDark80),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: Get.height * .1,
                )
              ],
            ),
          ),
        ));
  }
}
