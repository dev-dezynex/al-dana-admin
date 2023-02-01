import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_year_page_controller.dart';

class AddYearPageView extends GetView<AddYearPageController> {
  const AddYearPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddYearPageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AddYearPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
