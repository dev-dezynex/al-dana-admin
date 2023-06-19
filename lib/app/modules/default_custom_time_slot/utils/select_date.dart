import 'package:al_dana_admin/app/modules/default_custom_time_slot/providers/default_custom_time_slot_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/theme/colors.dart';

class SelectDate extends StatelessWidget {
  const SelectDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DefaultCustomProvider>(
      builder: (context, provider, _) {
        final width = MediaQuery.of(context).size.width;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SizedBox(
              width: width * 0.7,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    width: 1,
                    color: primary2,
                  ),
                ),
                child: TextField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    hintText: 'Select Date',
                  ),
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: provider.pickedDate != ''
                          ? DateFormat('yyyy-MM-dd').parse(provider.pickedDate)
                          : DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2080),
                    );
                    if (pickedDate != null) {
                      provider.setPickedDate(pickedDate);
                      provider.setIsDatePicked(true);
                    }
                  },
                  controller: TextEditingController(text: provider.pickedDate),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
