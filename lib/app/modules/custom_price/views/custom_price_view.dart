import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../controllers/custom_price_controller.dart';

class CustomPriceView extends GetView<CustomPriceController> {
  CustomPriceView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKeyAddPdf = GlobalKey<FormState>();
  late FocusNode focusNode1, focusNode2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor1,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            'Add Service',
            style:
                tsPoppins(size: 18, weight: FontWeight.w600, color: textDark80),
          ),
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(15)),
                  child: Form(
                    key: formKeyAddPdf,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Obx(
                            () => ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.selectedPriceList.length,
                                itemBuilder: (con, i) {
                                  return Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 15),
                                    margin: const EdgeInsets.only(bottom: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: textDark40)),
                                    child: Stack(
                                      children: [
                                        if (controller
                                                .selectedPriceList.length >
                                            1)
                                          Positioned(
                                            top: 10,
                                            right: 5,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: textDark80)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.removePrice(i);
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: textDark80,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Autocomplete<Variant>(
                                              optionsBuilder: (TextEditingValue
                                                  textEditingValue) {
                                                return controller.variantResult
                                                    .value.variantList
                                                    .where((Variant variant) =>
                                                        variant.title
                                                            .toLowerCase()
                                                            .startsWith(
                                                                textEditingValue
                                                                    .text
                                                                    .toLowerCase()))
                                                    .toList();
                                              },
                                              displayStringForOption:
                                                  (Variant option) =>
                                                      option.title,
                                              fieldViewBuilder:
                                                  (BuildContext context,
                                                      TextEditingController tec,
                                                      FocusNode fieldFocusNode,
                                                      VoidCallback
                                                          onFieldSubmitted) {
                                                controller
                                                        .variantControllerList[
                                                    i] = tec;
                                                focusNode1 = fieldFocusNode;
                                                return TextFormField(
                                                  controller: tec,
                                                  focusNode: fieldFocusNode,
                                                  validator: (value) {
                                                    if (controller
                                                            .selectedVariantsList
                                                            .isEmpty ||
                                                        controller
                                                            .selectedVariantsList[
                                                                i]
                                                            .isEmpty) {
                                                      return "Please select a variant";
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
                                                        const EdgeInsets.only(
                                                            left: 0),
                                                    labelText: "Variant",
                                                    labelStyle: tsPoppins(
                                                        size: 14,
                                                        weight: FontWeight.w400,
                                                        color: textColor02),
                                                    enabledBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: borderColor),
                                                    ),
                                                    focusedBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: borderColor),
                                                    ),
                                                  ),
                                                );
                                              },
                                              onSelected: (Variant selection) {
                                                print(
                                                    'Selected: ${selection.title}');
                                                controller
                                                    .variantControllerList[i]
                                                    .text = '';
                                                focusNode1.nextFocus();
                                              },
                                              optionsViewBuilder: (BuildContext
                                                      context,
                                                  AutocompleteOnSelected<
                                                          Variant>
                                                      onSelected,
                                                  Iterable<Variant> options) {
                                                return Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Material(
                                                    child: Container(
                                                      width: 300,
                                                      color: Colors.white,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        itemCount:
                                                            options.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          final Variant option =
                                                              options.elementAt(
                                                                  index);

                                                          return GestureDetector(
                                                            onTap: () {
                                                              onSelected(
                                                                  option);
                                                              bool contains =
                                                                  false;
                                                              for (int i = 0;
                                                                  i <
                                                                      controller
                                                                          .selectedVariantsList
                                                                          .length;
                                                                  i++) {
                                                                if (controller
                                                                    .selectedVariantsList[
                                                                        i]
                                                                    .contains(
                                                                        option)) {
                                                                  contains =
                                                                      true;
                                                                  break;
                                                                }
                                                              }

                                                              print(
                                                                  'variant contains: $contains');
                                                              if (!contains) {
                                                                controller
                                                                    .selectedVariantsList[
                                                                        i]
                                                                    .add(
                                                                        option);

                                                                controller
                                                                    .selectedPriceList
                                                                    .refresh();
                                                              } else {
                                                                Get.snackbar(
                                                                    'Variant already added',
                                                                    'Please choose another variant or remove it from previous',
                                                                    snackPosition:
                                                                        SnackPosition
                                                                            .BOTTOM,
                                                                    backgroundColor:
                                                                        textDark20,
                                                                    colorText:
                                                                        textDark80);
                                                              }
                                                            },
                                                            child: ListTile(
                                                              title: Text(
                                                                  option.title,
                                                                  style:
                                                                      tsPoppins(
                                                                    color:
                                                                        textDark40,
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
                                            if (controller
                                                .selectedVariantsList[i]
                                                .isNotEmpty)
                                              const SizedBox(
                                                height: 8,
                                              ),
                                            if (controller
                                                .selectedVariantsList[i]
                                                .isNotEmpty)
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: List.generate(
                                                      controller
                                                          .selectedVariantsList[
                                                              i]
                                                          .length,
                                                      (index) => Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                                    maxWidth:
                                                                        180),
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        8),
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 5),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    textDark10,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Flexible(
                                                                  child: Text(
                                                                    '${controller.selectedVariantsList[i][index].title}  ',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: tsPoppins(
                                                                        color:
                                                                            textDark80),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    print(
                                                                        'remove from list ${jsonEncode(controller.selectedVariantsList)}');
                                                                    print(
                                                                        'remove at $i  inner  $index');
                                                                    controller
                                                                        .selectedVariantsList[
                                                                            i]
                                                                        .removeAt(
                                                                            index);
                                                                    controller
                                                                        .selectedPriceList
                                                                        .refresh();
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons.close,
                                                                    color:
                                                                        textDark40,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )),
                                                ),
                                              ),
                                            const SizedBox(height: 15),
                                            TextFormField(
                                              controller: controller
                                                  .serviceModeControllerList[i],
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              keyboardType: TextInputType.text,
                                              readOnly: true,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please select the service modes";
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
                                                    const EdgeInsets.only(
                                                        left: 0),
                                                labelText: "Service Modes",
                                                labelStyle: tsPoppins(
                                                    size: 14,
                                                    weight: FontWeight.w400,
                                                    color: textColor02),
                                                enabledBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: borderColor,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: borderColor),
                                                ),
                                              ),
                                              onTap: () {
                                                controller.chooseMode(context,
                                                    selectedModesList: controller
                                                        .selectedModeLists[i],
                                                    textEditingController:
                                                        controller
                                                            .serviceModeControllerList[i]);
                                              },
                                            ),
                                            const SizedBox(height: 15),
                                            TextFormField(
                                              controller: controller
                                                  .priceControllerList[i],
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (String? value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "*Required";
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
                                                    const EdgeInsets.only(
                                                        left: 0),
                                                labelText:
                                                    "Price (default price for service in branch)",
                                                labelStyle: tsPoppins(
                                                    size: 14,
                                                    weight: FontWeight.w400,
                                                    color: textColor02),
                                                enabledBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: borderColor,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: borderColor),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                controller.addPrice();
                              },
                              child: Text(
                                'Add +',
                                style: tsPoppins(),
                              )),
                          if (controller.isLoading.value)
                            const Center(
                                child:
                                    CircularProgressIndicator(color: primary)),
                          if (!controller.isLoading.value &&
                              !controller.isUpdate.value)
                            ElevatedButton(
                                onPressed: () {
                                  if (formKeyAddPdf.currentState!.validate()) {
                                    controller.createPrice();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primary,
                                    minimumSize: Size(Get.width, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Text('Create Service',
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
                                              'Do you want to delete these custom prices ?',
                                          onCancel: () {
                                            Get.back();
                                          },
                                          onSubmit: () {
                                            controller.deletePrice();
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
                                      if (formKeyAddPdf.currentState!
                                          .validate()) {
                                        controller.createPrice();
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
