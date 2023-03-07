import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data.dart';

class CarModelTile extends StatelessWidget {
  const CarModelTile(
      {Key? key, required this.carModel, this.onTap, this.onEdit})
      : super(key: key);
  final CarModel carModel;
  final GestureTapCallback? onTap, onEdit;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration:
          BoxDecoration(color: white, borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  '$domainName${carModel.image!}',
                  fit: BoxFit.contain,
                  width: Get.width * .1,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      carModel.image!,
                      fit: BoxFit.contain,
                      width: Get.width * .1,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/img_placeholder.png',
                          fit: BoxFit.contain,
                          width: Get.width * .1,
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  width: 13,
                ),
                Text(
                  carModel.title!,
                  style: tsPoppins(
                      weight: FontWeight.w400, size: 14, color: textDark40),
                )
              ],
            ),
            IconButton(
              onPressed: onEdit,
              icon: const Icon(
                Icons.edit,
                color: textDark40,
              ),
            )
          ],
        ),
      ),
    );
  }
}
