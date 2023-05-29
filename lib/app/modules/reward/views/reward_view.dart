import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../controllers/reward_controller.dart';

class RewardView extends GetView<RewardController> {
  RewardView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKeyAdd = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor1,
        appBar: AppBar(
          title: const Text('Rewards'),
          centerTitle: true,
          leading: const GoBack(),
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            decoration: BoxDecoration(
                color: white, borderRadius: BorderRadius.circular(10)),
            child: Form(
              key: formKeyAdd,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 4,
                          child: TextFormField(
                            controller: controller.pointController,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.number,
                            readOnly: true,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Required point";
                              } else {
                                return null;
                              }
                            },
                            style: tsPoppins(
                                size: 14,
                                weight: FontWeight.w400,
                                color: textDark80),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 0),
                              labelText: "Point",
                              labelStyle: tsPoppins(
                                  size: 14,
                                  weight: FontWeight.w400,
                                  color: textColor02),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: borderColor,
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Icon(Icons.swap_horiz_outlined),
                        const SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          flex: 6,
                          child: TextFormField(
                            controller: controller.amountController,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.number,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Required Price";
                              } else {
                                return null;
                              }
                            },
                            style: tsPoppins(
                                size: 14,
                                weight: FontWeight.w400,
                                color: textDark80),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 0),
                              labelText: "Enter Price",
                              labelStyle: tsPoppins(
                                  size: 14,
                                  weight: FontWeight.w400,
                                  color: textColor02),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: borderColor,
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: controller.billamountController,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Required bill amount";
                        } else {
                          return null;
                        }
                      },
                      style: tsPoppins(
                          size: 14, weight: FontWeight.w400, color: textDark80),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 0),
                        labelText: "Enter Bill Amount",
                        labelStyle: tsPoppins(
                            size: 14,
                            weight: FontWeight.w400,
                            color: textColor02),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: borderColor,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: borderColor),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 65,
                    ),
                    if (controller.isLoading.value)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (!controller.isLoading.value)
                      ElevatedButton(
                          onPressed: () {
                            if (formKeyAdd.currentState!.validate()) {
                              controller.updateReward();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              minimumSize: Size(Get.width, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text('Update Reward',
                              style: tsPoppins(
                                  color: white,
                                  weight: FontWeight.w600,
                                  size: 15))),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
