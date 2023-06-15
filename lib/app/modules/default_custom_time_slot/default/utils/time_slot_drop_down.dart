import 'package:al_dana_admin/app/data/providers/time_slot_provider.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/default/providers/default_time_slot_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/theme/colors.dart';

class TimeSlotDropdown extends StatefulWidget {
  const TimeSlotDropdown({super.key});

  @override
  State<TimeSlotDropdown> createState() => _TimeSlotDropdownState();
}

class _TimeSlotDropdownState extends State<TimeSlotDropdown> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TimeSlotApiProvider>(context, listen: false).fetchTimeSlots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeSlotApiProvider>(
      builder: (context, provider, _) {
        final width = MediaQuery.of(context).size.width;
        if (provider.timeSlots != null) {
          final timeslots = provider.timeSlots?.data ?? [];
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
                  child: DropdownButtonFormField<String>(
                    items: timeslots.map<DropdownMenuItem<String>>((timeSlot) {
                      return DropdownMenuItem<String>(
                        value: timeSlot.sId,
                        child:
                            Text("${timeSlot.startTime} - ${timeSlot.endTime}"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      String timeSlotId = value ?? '';
                      Provider.of<DefaultProvider>(context, listen: false)
                          .setTimeSlotId(timeSlotId);
                      if (timeSlotId != '' || timeSlotId.isNotEmpty) {
                        Provider.of<DefaultProvider>(context, listen: false)
                            .setIsTimeSlotSelected(true);
                      }
                    },
                    decoration:
                        const InputDecoration(hintText: 'Select Time Slot'),
                  ),
                ),
              ),
            ),
          );
        } else if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.hasError) {
          return const Center(
            child: Text('Failed to load Time slot Dropdown'),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
