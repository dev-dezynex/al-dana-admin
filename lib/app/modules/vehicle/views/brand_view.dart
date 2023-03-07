import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';
import '../controllers/vehicle_controller.dart';

class BrandView extends GetView<VehicleController> {
  const BrandView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor1,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.ADD_BRAND)!
                .then((value) => value ? controller.getDetails() : null);
          },
          backgroundColor: primary,
          child: const Icon(
            Icons.add,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      Get.width * .05, 0, Get.width * .05, 15),
                  child: TextFormField(
                    autofocus: false,
                    onChanged: (value) {
                      controller.search(key: value);
                    },
                    style: tsPoppins(color: textDark80, size: 14),
                    decoration: InputFormDecoration.outLinedInputTextDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        suffixIcon: const Icon(
                          Icons.search,
                          color: textDark40,
                        ),
                        hintText: 'Search Vehicle',
                        hintStyle: tsPoppins(size: 14, color: textDark20),
                        radius: 100,
                        filled: true,
                        fillColor: white),
                  ),
                ),
                Obx(
                  () => ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      itemCount: controller.filterBrands.length,
                      itemBuilder: (con, i) {
                        return BrandTile(
                          onTap: () {
                            Get.toNamed(Routes.CAR_MODEL,
                                arguments: controller.filterBrands[i]);
                          },
                          onEdit: () {
                            Get.toNamed(Routes.ADD_BRAND,
                                    arguments: controller.filterBrands[i])!
                                .then((value) =>
                                    value ? controller.getDetails() : null);
                          },
                          brand: controller.filterBrands[i],
                        );
                      }),
                ),
                SizedBox(
                  height: Get.height * .1,
                )
              ],
            ),
          ),
        ));
  }
}
