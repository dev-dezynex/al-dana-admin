import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../controllers/add_service_controller.dart';

class AddServiceView extends GetView<AddServiceController> {
  AddServiceView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKeyAddPdf = GlobalKey<FormState>();
  late FocusNode focusNode1, focusNode2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                return "Required Description";
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
                              labelText: "Enter Description",
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
                          Autocomplete<Branch>(
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
                                  if (controller.selectedBranch.isEmpty) {
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
                              print('Selected: ${selection.name}');
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
                                            if (!controller.selectedBranch
                                                .contains(option)) {
                                              // controller.branchController.text =
                                              //     '';
                                              controller.selectedBranch
                                                  .add(option);
                                              controller.selectedBranch
                                                  .refresh();
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
                          if (controller.selectedBranch.isNotEmpty)
                            const SizedBox(
                              height: 8,
                            ),
                          if (controller.selectedBranch.isNotEmpty)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(
                                    controller.selectedBranch.length,
                                    (i) => Container(
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
                                              Text(
                                                '${controller.selectedBranch[i].name}  ',
                                                style: tsPoppins(
                                                    color: textDark80),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller.selectedBranch
                                                      .remove(controller
                                                          .selectedBranch[i]);
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
                          Autocomplete<Category>(
                            initialValue: TextEditingValue(
                                text: controller.categoryController.text),
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              return controller
                                  .categoryResult.value.categoryList
                                  .where((Category category) => category.title
                                      .toLowerCase()
                                      .startsWith(
                                          textEditingValue.text.toLowerCase()))
                                  .toList();
                            },
                            displayStringForOption: (Category option) =>
                                option.title,
                            fieldViewBuilder: (BuildContext context,
                                TextEditingController tec,
                                FocusNode fieldFocusNode,
                                VoidCallback onFieldSubmitted) {
                              controller.categoryController = tec;
                              focusNode1 = fieldFocusNode;
                              return TextFormField(
                                controller: tec,
                                focusNode: fieldFocusNode,
                                validator: (value) {
                                  if (controller
                                      .selectedCategory.value.id.isEmpty) {
                                    return "Please select a category";
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
                                  labelText: "Category",
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
                            onSelected: (Category selection) {
                              print('Selected: ${selection.title}');
                              controller.categoryController.text = '';
                              focusNode1.unfocus();
                            },
                            optionsViewBuilder: (BuildContext context,
                                AutocompleteOnSelected<Category> onSelected,
                                Iterable<Category> options) {
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
                                        final Category option =
                                            options.elementAt(index);

                                        return GestureDetector(
                                          onTap: () {
                                            onSelected(option);

                                            controller.categoryController.text =
                                                option.title;
                                            controller.selectedCategory.value =
                                                option;
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

                          // const SizedBox(
                          //   height: 15,
                          // ),
                          // Autocomplete<Work>(
                          //   optionsBuilder:
                          //       (TextEditingValue textEditingValue) {
                          //     return controller.workResult.value.workList
                          //         .where((Work value) => value.title
                          //             .toLowerCase()
                          //             .startsWith(
                          //                 textEditingValue.text.toLowerCase()))
                          //         .toList();
                          //   },
                          //   displayStringForOption: (Work option) =>
                          //       option.title,
                          //   fieldViewBuilder: (BuildContext context,
                          //       TextEditingController tec,
                          //       FocusNode fieldFocusNode,
                          //       VoidCallback onFieldSubmitted) {
                          //     controller.workController = tec;
                          //     focusNode2 = fieldFocusNode;
                          //     return TextFormField(
                          //       controller: tec,
                          //       focusNode: fieldFocusNode,
                          //       validator: (value) {
                          //         if (controller.selectedWork.isEmpty) {
                          //           return "Please select at least one work";
                          //         } else {
                          //           return null;
                          //         }
                          //       },
                          //       style: tsPoppins(
                          //           size: 14,
                          //           weight: FontWeight.w400,
                          //           color: textDark80),
                          //       decoration: InputDecoration(
                          //         contentPadding:
                          //             const EdgeInsets.only(left: 0),
                          //         labelText: "Work",
                          //         labelStyle: tsPoppins(
                          //             size: 14,
                          //             weight: FontWeight.w400,
                          //             color: textColor02),
                          //         enabledBorder: const UnderlineInputBorder(
                          //           borderSide: BorderSide(
                          //             color: borderColor,
                          //           ),
                          //         ),
                          //         focusedBorder: const UnderlineInputBorder(
                          //           borderSide: BorderSide(color: borderColor),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          //   onSelected: (Work selection) {
                          //     print('Selected: ${selection.title}');
                          //     controller.workController.text = '';
                          //     focusNode2.unfocus();
                          //   },
                          //   optionsViewBuilder: (BuildContext context,
                          //       AutocompleteOnSelected<Work> onSelected,
                          //       Iterable<Work> options) {
                          //     return Align(
                          //       alignment: Alignment.topLeft,
                          //       child: Material(
                          //         child: Container(
                          //           width: 300,
                          //           color: Colors.white,
                          //           child: ListView.builder(
                          //             shrinkWrap: true,
                          //             padding: const EdgeInsets.all(10.0),
                          //             itemCount: options.length,
                          //             itemBuilder:
                          //                 (BuildContext context, int index) {
                          //               final Work option =
                          //                   options.elementAt(index);
                          //               return GestureDetector(
                          //                 onTap: () {
                          //                   onSelected(option);
                          //                   if (!controller.selectedWork
                          //                       .contains(option)) {
                          //                     // controller.branchController.text =
                          //                     //     '';
                          //                     controller.selectedWork
                          //                         .add(option);
                          //                     controller.selectedBranch
                          //                         .refresh();
                          //                   }
                          //                 },
                          //                 child: ListTile(
                          //                   title: Text(option.title,
                          //                       style: tsPoppins(
                          //                         color: textDark40,
                          //                         size: 14,
                          //                       )),
                          //                 ),
                          //               );
                          //             },
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),
                          // if (controller.selectedWork.isNotEmpty)
                          //   const SizedBox(
                          //     height: 8,
                          //   ),
                          // if (controller.selectedWork.isNotEmpty)
                          //   SingleChildScrollView(
                          //     scrollDirection: Axis.horizontal,
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       children: List.generate(
                          //           controller.selectedWork.length,
                          //           (i) => Container(
                          //                 constraints: const BoxConstraints(
                          //                     maxWidth: 180),
                          //                 padding: const EdgeInsets.symmetric(
                          //                     vertical: 5, horizontal: 8),
                          //                 margin:
                          //                     const EdgeInsets.only(right: 5),
                          //                 decoration: BoxDecoration(
                          //                     color: textDark10,
                          //                     borderRadius:
                          //                         BorderRadius.circular(5)),
                          //                 child: Row(
                          //                   mainAxisSize: MainAxisSize.min,
                          //                   children: [
                          //                     Flexible(
                          //                       child: Text(
                          //                         '${controller.selectedWork[i].title}  ',
                          //                         overflow:
                          //                             TextOverflow.ellipsis,
                          //                         style: tsPoppins(
                          //                             color: textDark80),
                          //                       ),
                          //                     ),
                          //                     GestureDetector(
                          //                       onTap: () {
                          //                         controller.selectedWork
                          //                             .remove(controller
                          //                                 .selectedWork[i]);
                          //                       },
                          //                       child: const Icon(
                          //                         Icons.close,
                          //                         color: textDark40,
                          //                       ),
                          //                     )
                          //                   ],
                          //                 ),
                          //               )),
                          //     ),
                          //   ),

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
                                          color: controller.bgCardColor.value,
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
                                    controller.createService();
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
                                              'Do you want to delete this service ?',
                                          onCancel: () {
                                            Get.back();
                                          },
                                          onSubmit: () {
                                            controller.deleteService();
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
                                        controller.updateService();
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
