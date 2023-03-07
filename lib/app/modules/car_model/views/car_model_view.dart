import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';
import '../controllers/car_model_controller.dart';

class CarModelView extends GetView<CarModelController> {
  const CarModelView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor1,
        appBar: AppBar(
          leading: const GoBack(),
          centerTitle: true,
          title: Text(
            'Car Models',
            style:
                tsPoppins(size: 18, weight: FontWeight.w600, color: textDark80),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.ADD_CAR_MODEL,
                    arguments: [false, controller.selectedBrand.value])!
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
                        controller.carModelResult.value.carModelList!.length,
                    itemBuilder: (con, i) {
                      return CarModelTile(
                        onTap: () {
                          Get.toNamed(Routes.VARIANT,
                              arguments: controller
                                  .carModelResult.value.carModelList![i]);
                        },
                        onEdit: () {
                          Get.toNamed(Routes.ADD_CAR_MODEL, arguments: [
                            true,
                            controller.carModelResult.value.carModelList![i]
                          ])!
                              .then((value) =>
                                  value ? controller.getDetails() : null);
                        },
                        carModel:
                            controller.carModelResult.value.carModelList![i],
                      );
                    }),
          ),
        ));
  }
}
