import 'package:al_dana_admin/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerTile extends StatelessWidget {
  const BannerTile({super.key, required this.imagePath, this.onTap});
  final String imagePath;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width,
        margin: const EdgeInsets.only(bottom: 5.0),
        child: Card(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 0.0,
            child: Image.network('$domainName$imagePath', fit: BoxFit.contain)),
      ),
    );
  }
}
