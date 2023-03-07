import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data.dart';

class VehicleTile extends StatelessWidget {
  const VehicleTile({Key? key, required this.vehicle}) : super(key: key);
  final Vehicle vehicle;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: textDark20),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: Image.network(
                vehicle.image!,
                fit: BoxFit.contain,
                width: Get.width * .15,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    vehicle.image!,
                    fit: BoxFit.contain,
                    width: Get.width * .15,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/img_placeholder.png',
                        fit: BoxFit.contain,
                        width: Get.width * .2,
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              width: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${vehicle.brand!.name} - ${vehicle.variant!.title}',
                    style: tsPoppins(color: textDark80, size: 16)),
                Text('Year ${vehicle.year!.name} | ${vehicle.colour!.name}',
                    style: tsPoppins(
                      color: textDark40,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
