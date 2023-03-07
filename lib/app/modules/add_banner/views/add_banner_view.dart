import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../controllers/add_banner_controller.dart';

class AddBannerView extends GetView<AddBannerController> {
  AddBannerView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKeyAdd = GlobalKey<FormState>();
  late FocusNode focusNode1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor1,
        appBar: AppBar(
          title: Text(
            'Add Banner',
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
                          Autocomplete<Branch>(
                            initialValue: TextEditingValue(
                                text: controller.branchController.text),
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              return controller.branchResult.value.branchList!
                                  .where((Branch branch) => branch.name
                                      .toLowerCase()
                                      .startsWith(
                                          textEditingValue.text.toLowerCase()))
                                  .toList();
                            },
                            displayStringForOption: (Branch option) =>
                                option.name,
                            fieldViewBuilder: (BuildContext context,
                                TextEditingController tec,
                                FocusNode fieldFocusNode,
                                VoidCallback onFieldSubmitted) {
                              controller.branchController = tec;
                              focusNode1 = fieldFocusNode;
                              return TextFormField(
                                controller: tec,
                                focusNode: fieldFocusNode,
                                validator: (value) {
                                  if (controller
                                      .selectedBranch.value.id.isEmpty) {
                                    return "Please select at least one branch";
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
                                  labelText: "Branch",
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
                              );
                            },
                            onSelected: (Branch selection) {
                              controller.branchController.text = '';
                              focusNode1.unfocus();
                            },
                            optionsViewBuilder: (BuildContext context,
                                AutocompleteOnSelected<Branch> onSelected,
                                Iterable<Branch> options) {
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
                                        final Branch option =
                                            options.elementAt(index);

                                        return GestureDetector(
                                          onTap: () {
                                            onSelected(option);
                                            controller.selectedBranch.value =
                                                option;
                                            controller.branchController.text =
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
                            height: 15,
                          ),
                          TextFormField(
                            controller: controller.thumbController,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            style: tsPoppins(
                                size: 14,
                                weight: FontWeight.w400,
                                color: textDark80),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.photo_library_rounded,
                                color: textDark60,
                              ),
                              suffix: IconButton(
                                  onPressed: () {
                                    controller.thumbController.text = '';
                                    controller.thumbFile.value = File('');
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: textDark60,
                                  )),
                              contentPadding: const EdgeInsets.only(left: 0),
                              labelText: "Upload Image",
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
                            onTap: () {
                              controller.pickThumb();
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
                                    controller.createBanner();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primary,
                                    minimumSize: Size(Get.width, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Text('Create Banner',
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
                                            controller.deleteBanner();
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
                                        controller.createBanner();
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
