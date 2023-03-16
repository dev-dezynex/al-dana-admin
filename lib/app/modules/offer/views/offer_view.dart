import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/offer_controller.dart';

class OfferView extends GetView<OfferController> {
  const OfferView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OfferView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OfferView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
