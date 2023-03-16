import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';
import '../controllers/category_list_controller.dart';

class CategoryListView extends GetView<CategoryListController> {
  const CategoryListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Categories',
            style:
                tsPoppins(size: 18, weight: FontWeight.w600, color: textDark80),
          ),
          centerTitle: true,
          leading: const GoBack(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.ADD_CATEGORY)!
                .then((value) => value ? controller.getCategories() : null);
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
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Get.width ~/ 166,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1 / 1.1),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    itemCount:
                        controller.categoryResult.value.categoryList.length,
                    itemBuilder: (con, i) {
                      return CategoryTile(
                          isManage: true,
                          onEdit: () {
                            Get.toNamed(Routes.ADD_CATEGORY,
                                    arguments: controller
                                        .categoryResult.value.categoryList[i])!
                                .then((value) =>
                                    value ? controller.getCategories() : null);
                          },
                          category:
                              controller.categoryResult.value.categoryList[i]);
                    }),
          ),
        ));
  }
}
