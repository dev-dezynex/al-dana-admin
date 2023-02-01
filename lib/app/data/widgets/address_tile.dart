import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../data.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start  ,
          children: [
            Text('Home Address',
                style: tsPoppins(weight: FontWeight.w400, color: textDark80)),
            Text('Mohammed Bin Rashid, Building, Dubai, \nUnited arab emirates',
                style: tsPoppins(weight: FontWeight.w600, color: textDark80)),
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset('assets/icons/ic_call.svg'),
                    Text(' +974 9547362817 ',
                        style: tsPoppins(
                            weight: FontWeight.w400, color: textDark80)),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: textDark80,
                      size: 10,
                    ),
                    Text(' 12 km ',
                        style: tsPoppins(
                            weight: FontWeight.w400, color: textDark80)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
