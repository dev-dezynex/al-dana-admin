import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';
import '../controllers/vehicle_controller.dart';

class ColorsView extends GetView<VehicleController> {
  const ColorsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor1,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getColorPickerWithName(
              context: context,
              pickerColor: controller.selectedColor.value,
              onColorChanged: (Color value) {
                controller.selectedColor.value = value;
              },
              displayThumbColor2: false,
              enableAlpha2: false,
              nameController: controller.colorNameController,
              onCancel: () {
                Get.back();
              },
              onSubmit: () {
                controller.addColorToList();
              });
        },
        backgroundColor: primary,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: white,
              border: Border.all(color: textDark20, width: 1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                '    Select Color',
                style: tsPoppins(size: 14, color: textDark40),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1 / 1.1,
                      ),
                      itemCount: controller.colorList.length,
                      itemBuilder: (con, i) {
                        return InkWell(
                          onTap: () {
                            myAlertDialog(
                                title: 'Confirm',
                                message:
                                    'Do you want to delete ${controller.colorList[i].name} ?',
                                onCancel: () {
                                  Get.back();
                                },
                                onSubmit: () {
                                  controller
                                      .deleteColor(controller.colorList[i]);
                                });
                          },
                          child: Container(
                            width: 15,
                            decoration: BoxDecoration(
                                border: Border.all(color: textDark20),
                                shape: BoxShape.circle,
                                color:
                                    hexToColor(controller.colorList[i].code!)),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
