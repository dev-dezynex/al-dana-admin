import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';
import '../controllers/variant_controller.dart';

class VariantView extends GetView<VariantController> {
  const VariantView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor1,
        appBar: AppBar(
          leading: const GoBack(),
          centerTitle: true,
          title: Text(
            'Car Variant',
            style:
                tsPoppins(size: 18, weight: FontWeight.w600, color: textDark80),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.ADD_VARIANT,
                    arguments: [false, controller.selectedModel.value])!
                .then((value) => value ? controller.getDetails() : null);
          },
          backgroundColor: primary,
          child: const Icon(
            Icons.add,
          ),
        ),
        body: SafeArea(
          child: Obx(
            () => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    itemCount:
                        controller.carVariantResult.value.variantList.length,
                    itemBuilder: (con, i) {
                      return CarVariantTile(
                        onEdit: () {
                          Get.toNamed(Routes.ADD_VARIANT, arguments: [
                            true,
                            controller.carVariantResult.value.variantList[i]
                          ])!
                              .then((value) =>
                                  value ? controller.getDetails() : null);
                        },
                        carVariant:
                            controller.carVariantResult.value.variantList[i],
                      );
                    }),
          ),
        ));
  }
}
