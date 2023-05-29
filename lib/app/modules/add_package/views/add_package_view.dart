import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';
import '../controllers/add_package_controller.dart';

class AddPackageView extends GetView<AddPackageController> {
  AddPackageView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKeyAddPdf = GlobalKey<FormState>();
  late FocusNode focusNode1, focusNode2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            'Add Package',
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
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(15)),
                  child: Form(
                    key: formKeyAddPdf,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            controller: controller.descController,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
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
                              contentPadding: const EdgeInsets.only(left: 0),
                              labelText: "Description",
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
                          
                          if (!controller.isCustomBranch.value)
                            TextFormField(
                              controller: controller.serviceModeController,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.text,
                              readOnly: true,
                              style: tsPoppins(
                                  size: 14,
                                  weight: FontWeight.w400,
                                  color: textDark80),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 0),
                                labelText: "Service Modes",
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
                                controller.chooseMode(context,
                                    selectedModesList:
                                        controller.selectedModeList,
                                    textEditingController:
                                        controller.serviceModeController);
                              },
                            ),
                          if (!controller.isCustomBranch.value)
                            const SizedBox(height: 15),
                          if (!controller.isCustomBranch.value)
                            Autocomplete<Service>(
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                return controller
                                    .serviceResult.value.serviceList
                                    .where((Service value) => value.title
                                        .toLowerCase()
                                        .startsWith(textEditingValue.text
                                            .toLowerCase()))
                                    .toList();
                              },
                              displayStringForOption: (Service option) =>
                                  option.title,
                              fieldViewBuilder: (BuildContext context,
                                  TextEditingController tec,
                                  FocusNode fieldFocusNode,
                                  VoidCallback onFieldSubmitted) {
                                controller.serviceController = tec;
                                focusNode1 = fieldFocusNode;
                                return TextFormField(
                                  controller: tec,
                                  focusNode: fieldFocusNode,
                                  validator: (value) {
                                    if (controller.selectedServices.isEmpty) {
                                      return "Please select at least one service";
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
                                    labelText: "Select Service",
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
                              onSelected: (Service selection) {
                                print('Selected: ${selection.title}');
                                controller.serviceController.text = '';
                                focusNode1.unfocus();
                              },
                              optionsViewBuilder: (BuildContext context,
                                  AutocompleteOnSelected<Service> onSelected,
                                  Iterable<Service> options) {
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
                                          final Service option =
                                              options.elementAt(index);

                                          return GestureDetector(
                                            onTap: () {
                                              onSelected(option);
                                              if (!controller.selectedServices
                                                  .contains(option)) {
                                                controller.serviceController
                                                    .text = '';
                                                controller.selectedServices
                                                    .add(option);
                                                controller.selectedServices
                                                    .refresh();
                                              }
                                            },
                                            child: ListTile(
                                              title: Text(option.title,
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
                          if (controller.selectedServices.isNotEmpty &&
                              !controller.isCustomBranch.value)
                            const SizedBox(
                              height: 8,
                            ),
                          if (controller.selectedServices.isNotEmpty &&
                              !controller.isCustomBranch.value)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(
                                    controller.selectedServices.length,
                                    (i) => Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 180),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 8),
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          decoration: BoxDecoration(
                                              color: textDark10,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  '${controller.selectedServices[i].title}  ',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: tsPoppins(
                                                      color: textDark80),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller.selectedServices
                                                      .remove(controller
                                                          .selectedServices[i]);
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: textDark40,
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                              ),
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
                              labelText: "Upload Thumbnail",
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
                            height: 15,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Card BG color',
                                    style: tsPoppins(color: textDark),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          getColorPicker(
                                              context: context,
                                              pickerColor:
                                                  controller.bgCardColor.value,
                                              onColorChanged: (value) {
                                                controller.bgCardColor.value =
                                                    value;
                                              },
                                              displayThumbColor2: false,
                                              enableAlpha2: false);
                                        },
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color:
                                                  controller.bgCardColor.value,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        colorToHexValue(
                                            controller.bgCardColor.value),
                                        style: tsPoppins(color: textDark),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Customize For Branch',
                                    style: tsPoppins(color: textDark),
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  Switch(
                                      value: controller.isCustomBranch.value,
                                      onChanged: (bool v) {
                                        controller.isCustomBranch.value = v;
                                      })
                                ],
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                          if (controller.isCustomBranch.value)
                            const SizedBox(
                              height: 15,
                            ),
                          if (controller.isCustomBranch.value)
                            customPackageForBranch(context),
                          const SizedBox(
                            height: 35,
                          ),
                          if (controller.isLoading.value)
                            const Center(
                                child:
                                    CircularProgressIndicator(color: primary)),
                          if (!controller.isLoading.value &&
                              !controller.isUpdate.value)
                            ElevatedButton(
                                onPressed: () {
                                  if (formKeyAddPdf.currentState!.validate()) {
                                    controller.createPackage();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primary,
                                    minimumSize: Size(Get.width, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Text('Create Package',
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
                                              'Do you want to delete this package ?',
                                          onCancel: () {
                                            Get.back();
                                          },
                                          onSubmit: () {
                                            controller.deletePackage();
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
                                        controller.updatePackage();
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

  customPackageForBranch(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Obx(
          () => ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:
                  controller.selectedPackage.value.packageDetailList!.length,
              itemBuilder: (con, i) {
                return Container(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: textDark40)),
                  child: Stack(
                    children: [
                      if (controller
                              .selectedPackage.value.packageDetailList!.length >
                          1)
                        Positioned(
                          top: 10,
                          right: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: textDark80)),
                            child: GestureDetector(
                              onTap: () {
                                controller.removeBranch(i);
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Autocomplete<Branch>(
                            initialValue: TextEditingValue(
                                text: controller.branchControllerList[i].text),
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
                              controller.branchControllerList[i] = tec;
                              focusNode1 = fieldFocusNode;
                              return TextFormField(
                                controller: tec,
                                focusNode: fieldFocusNode,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please select a branch";
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
                              print('Selected: ${selection.name}');
                              controller.branchControllerList[i].text = '';
                              focusNode1.nextFocus();
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
                                            if (!controller.selectedBranchList
                                                .contains(option)) {
                                              controller.branchControllerList[i]
                                                  .text = option.name;
                                              controller.selectedBranchList
                                                  .insert(i, option);
                                              controller.selectedBranchList
                                                  .refresh();
                                            } else {
                                              Get.snackbar(
                                                  'Branch already added',
                                                  'The selected branch is already added',
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  backgroundColor: textDark20,
                                                  colorText: textDark80);
                                            }
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
                          const SizedBox(height: 15),
                          Autocomplete<Service>(
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              return controller.serviceResult.value.serviceList
                                  .where((Service value) => value.title
                                      .toLowerCase()
                                      .startsWith(
                                          textEditingValue.text.toLowerCase()))
                                  .toList();
                            },
                            displayStringForOption: (Service option) =>
                                option.title,
                            fieldViewBuilder: (BuildContext context,
                                TextEditingController tec,
                                FocusNode fieldFocusNode,
                                VoidCallback onFieldSubmitted) {
                              controller.serviceControllerList[i] = tec;
                              focusNode1 = fieldFocusNode;
                              return TextFormField(
                                controller: tec,
                                focusNode: fieldFocusNode,
                                validator: (value) {
                                  if (controller
                                      .selectedPackage
                                      .value
                                      .packageDetailList![i]
                                      .services!
                                      .isEmpty) {
                                    return "Please select at least one service";
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
                                  labelText: "Select Service",
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
                            onSelected: (Service selection) {
                              print('Selected: ${selection.title}');
                              controller.serviceControllerList[i].text = '';
                              focusNode1.unfocus();
                            },
                            optionsViewBuilder: (BuildContext context,
                                AutocompleteOnSelected<Service> onSelected,
                                Iterable<Service> options) {
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
                                        final Service option =
                                            options.elementAt(index);

                                        return GestureDetector(
                                          onTap: () {
                                            onSelected(option);
                                            if (!controller
                                                .selectedPackage
                                                .value
                                                .packageDetailList![i]
                                                .services!
                                                .any(
                                                    (e) => e.id == option.id)) {
                                              controller
                                                  .serviceControllerList[i]
                                                  .text = '';
                                              controller
                                                  .selectedPackage
                                                  .value
                                                  .packageDetailList![i]
                                                  .services!
                                                  .add(option);
                                              controller.selectedPackage
                                                  .refresh();
                                            }
                                          },
                                          child: ListTile(
                                            title: Text(option.title,
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
                          if (controller.selectedPackage.value
                              .packageDetailList![i].services!.isNotEmpty)
                            const SizedBox(
                              height: 8,
                            ),
                          if (controller.selectedPackage.value
                              .packageDetailList![i].services!.isNotEmpty)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(
                                    controller.selectedPackage.value
                                        .packageDetailList![i].services!.length,
                                    (index) => Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 180),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 8),
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          decoration: BoxDecoration(
                                              color: textDark10,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  '${controller.selectedPackage.value.packageDetailList![i].services![index].title}  ',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: tsPoppins(
                                                      color: textDark80),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .selectedPackage
                                                      .value
                                                      .packageDetailList![i]
                                                      .services!
                                                      .removeWhere((e) =>
                                                          e.id ==
                                                          controller
                                                              .selectedPackage
                                                              .value
                                                              .packageDetailList![
                                                                  i]
                                                              .services![index]
                                                              .id);
                                                  controller.selectedPackage
                                                      .refresh();
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: textDark40,
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                              ),
                            ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: controller.serviceModeControllerList[i],
                            textAlignVertical: TextAlignVertical.center,
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
                              contentPadding: const EdgeInsets.only(left: 0),
                              labelText: "Service Modes",
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
                              controller.chooseMode(context,
                                  selectedModesList:
                                      controller.selectedModeLists[i],
                                  textEditingController:
                                      controller.serviceModeControllerList[i]);
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: controller.priceControllerList[i],
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.number,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
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
                              contentPadding: const EdgeInsets.only(left: 0),
                              labelText:
                                  "Price (default price for service in branch)",
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
              controller.addBranch();
            },
            child: Text(
              'Add +',
              style: tsPoppins(),
            ))
      ],
    );
  }
}
