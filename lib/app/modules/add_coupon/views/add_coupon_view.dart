import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../controllers/add_coupon_controller.dart';

class AddCouponView extends GetView<AddCouponController> {
  AddCouponView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKeyAdd = GlobalKey<FormState>();
  late FocusNode focusNode1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor1,
        appBar: AppBar(
          title: const Text('AddCouponView'),
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(15)),
                  child: Form(
                    key: formKeyAdd,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: controller.titleController,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Required Title";
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
                              labelText: "Enter Title",
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
                            height: 15,
                          ),
                          TextFormField(
                            controller: controller.priceController,
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
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: controller.discountController,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.number,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Required discount";
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
                              labelText: "Enter discount price",
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
                                          labelStyle: tsPoppins()),
                                  onTap: () {
                                    DatePicker.showDateTimePicker(
                                      context,
                                      showTitleActions: true,
                                      minTime: DateTime.now(),
                                      maxTime: DateTime.now()
                                          .add(Duration(days: 365)),
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
                              const SizedBox(
                                width: 15,
                              ),
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
                                            .add(Duration(days: 365)),
                                        onChanged: (date) {
                                      print('change $date');
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
                              decoration: InputFormDecoration
                                  .outLinedInputTextDecoration(
                                      borderSide: const BorderSide(
                                        color: textDark40,
                                      ),
                                      labelText: "Select coupon type",
                                      labelStyle: tsPoppins(
                                          color: textDark40.withOpacity(.5),
                                          weight: FontWeight.w400)),
                              value: controller.selectedCouponType,
                              items: controller.couponTypeList.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: tsPoppins(
                                          color: textDark80, size: 14)),
                                );
                              }).toList(),
                              onChanged: (value) {
                                controller.selectedCouponType = value!;
                                controller.couponTypeList.refresh();
                              }),
                          if (controller.selectedCouponType ==
                              controller.couponTypeList[1])
                            const SizedBox(
                              height: 15,
                            ),
                          if (controller.selectedCouponType ==
                              controller.couponTypeList[1])
                            Autocomplete<User>(
                              initialValue: TextEditingValue(
                                  text: controller.userController.text),
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                return controller.userResult.value.userList
                                    .where((User user) => user.name
                                        .toLowerCase()
                                        .startsWith(textEditingValue.text
                                            .toLowerCase()))
                                    .toList();
                              },
                              displayStringForOption: (User option) =>
                                  option.name,
                              fieldViewBuilder: (BuildContext context,
                                  TextEditingController tec,
                                  FocusNode fieldFocusNode,
                                  VoidCallback onFieldSubmitted) {
                                controller.userController = tec;
                                focusNode1 = fieldFocusNode;
                                return TextFormField(
                                  controller: tec,
                                  focusNode: fieldFocusNode,
                                  validator: (value) {
                                    if (controller
                                        .selectedUser.value.id.isEmpty) {
                                      return "Please select at least one user";
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: tsPoppins(
                                      size: 14,
                                      weight: FontWeight.w400,
                                      color: textDark80),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 0),
                                    labelText: "User",
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
                                      borderSide:
                                          BorderSide(color: borderColor),
                                    ),
                                  ),
                                );
                              },
                              onSelected: (User selection) {
                                controller.userController.text = '';
                                focusNode1.unfocus();
                              },
                              optionsViewBuilder: (BuildContext context,
                                  AutocompleteOnSelected<User> onSelected,
                                  Iterable<User> options) {
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    child: Container(
                                      width: 300,
                                      color: Colors.white,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(10.0),
                                        itemCount: options.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final User option =
                                              options.elementAt(index);

                                          return GestureDetector(
                                            onTap: () {
                                              onSelected(option);
                                              controller.selectedUser.value =
                                                  option;
                                              controller.userController.text =
                                                  option.name;
                                            },
                                            child: ListTile(
                                              title: Text(option.name,
                                                  style: tsPoppins(
                                                    color: textDark40,
                                                    size: 14,
                                                  )),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          const SizedBox(
                            height: 35,
                          ),
                          if (controller.isLoading.value)
                            const CircularProgressIndicator(color: primary),
                          if (!controller.isLoading.value &&
                              !controller.isUpdate.value)
                            ElevatedButton(
                                onPressed: () {
                                  if (formKeyAdd.currentState!.validate()) {
                                    controller.createCoupon();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primary,
                                    minimumSize: Size(Get.width, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Text('Create Coupon',
                                    style: tsPoppins(
                                        color: white,
                                        weight: FontWeight.w600,
                                        size: 15))),
                          if (!controller.isLoading.value &&
                              controller.isUpdate.value)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      myAlertDialog(
                                          title: 'Confirm',
                                          message:
                                              'Do you want to delete this Variant ?',
                                          onCancel: () {
                                            Get.back();
                                          },
                                          onSubmit: () {
                                            controller.deleteCoupon();
                                          });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: white,
                                        minimumSize: Size(Get.width * .4, 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: const BorderSide(
                                                color: primary, width: 2))),
                                    child: Text('Delete',
                                        style: tsPoppins(
                                            color: primary,
                                            weight: FontWeight.w600,
                                            size: 15))),
                                ElevatedButton(
                                    onPressed: () {
                                      if (formKeyAdd.currentState!.validate()) {
                                        controller.editCoupon();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: primary,
                                        minimumSize: Size(Get.width * .4, 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    child: Text('Update',
                                        style: tsPoppins(
                                            color: white,
                                            weight: FontWeight.w600,
                                            size: 15))),
                              ],
                            ),
                          const SizedBox(
                            height: 35,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
