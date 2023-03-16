import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_color_page_controller.dart';

class AddColorPageView extends GetView<AddColorPageController> {
  const AddColorPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddColorPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddColorPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
