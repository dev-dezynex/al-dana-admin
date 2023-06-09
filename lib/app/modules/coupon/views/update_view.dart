import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/modules/coupon/controllers/coupon_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';

class UpdateCouponView extends GetView<CouponController> {
  UpdateCouponView({
    Key? key,
    required this.id,
  }) : super(key: key);
  final GlobalKey<FormState> formKeyUpdate = GlobalKey<FormState>();
  late FocusNode focusNode1;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Coupon View'),
        centerTitle: true,
        leading: const GoBack(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Get.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(15)),
                child: Form(
                  key: formKeyUpdate,
                  child: Obx(
                    () => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: controller.discountAmountController,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Required discount amount';
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
                              labelText: 'Enter Discount Amount',
                              labelStyle: tsPoppins(
                                  size: 14,
                                  weight: FontWeight.w400,
                                  color: textColor02),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: borderColor))),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: controller.amountController,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Required amount";
                            } else {
                              return null;
                            }
                          },
                          style: tsPoppins(
                              size: 14,
                              weight: FontWeight.bold,
                              color: textDark80),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 0),
                            labelText: 'Enter amount',
                            labelStyle: tsPoppins(
                                size: 14,
                                weight: FontWeight.w400,
                                color: textColor02),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: borderColor,
                            )),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: borderColor),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: controller.startDateController,
                                readOnly: true,
                                decoration: InputFormDecoration
                                    .outLinedInputTextDecoration(
                                  labelText: 'Start Date',
                                  labelStyle: tsPoppins(),
                                ),
                                onTap: () {
                                  DatePicker.showDateTimePicker(
                                    context,
                                    showTitleActions: true,
                                    minTime: DateTime.now(),
                                    maxTime: DateTime.now()
                                        .add(const Duration(days: 365)),
                                    onChanged: (date) {
                                      print('change $date');
                                    },
                                    onConfirm: (date) {
                                      controller.setStartDate(date);
                                    },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 15),
                            Flexible(
                              child: TextFormField(
                                controller: controller.endDateController,
                                readOnly: true,
                                decoration: InputFormDecoration
                                    .outLinedInputTextDecoration(
                                        labelText: 'End Date',
                                        labelStyle: tsPoppins()),
                                onTap: () {
                                  DatePicker.showDateTimePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime.now(),
                                      maxTime: DateTime.now()
                                          .add(const Duration(days: 365)),
                                      onChanged: (date) {
                                    print('Change $date');
                                  }, onConfirm: (date) {
                                    controller.setEndDate(date);
                                  },
                                      currentTime: controller.startDate,
                                      locale: LocaleType.en);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          decoration:
                              InputFormDecoration.outLinedInputTextDecoration(
                            borderSide: const BorderSide(
                              color: textDark40,
                            ),
                            labelText: 'Select coupon type',
                            labelStyle: tsPoppins(
                                color: textDark40.withOpacity(.5),
                                weight: FontWeight.w400),
                          ),
                          value: controller.selectedCouponType.value,
                          items: controller.couponTypeList.map((value) {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: tsPoppins(color: textDark80, size: 14),
                                ));
                          }).toList(),
                          onChanged: (value) {
                            controller.selectedCouponType.value = value!;
                            controller.couponTypeList.refresh();
                          },
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        if (controller.isLoading.value)
                          const CircularProgressIndicator(
                            color: primary,
                          ),
                        if (!controller.isLoading.value)
                          ElevatedButton(
                            onPressed: () {
                              if (formKeyUpdate.currentState!.validate()) {
                                controller.updateCoupon(id);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              minimumSize: Size(Get.width, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Text(
                              'Update Coupon',
                              style: tsPoppins(
                                  color: white,
                                  weight: FontWeight.w600,
                                  size: 15),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
