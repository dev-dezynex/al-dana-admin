import 'package:al_dana_admin/app/data/data.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/extra_charge_controller.dart';

class ExtraChargeView extends GetView<ExtraChargeController> {
  const ExtraChargeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Extra Charge',
          style: TextStyle(color: white),
        ),
        centerTitle: true,
        backgroundColor: primary,
      ),
      body: const Center(
        child: Text(
          'ExtraChargeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
