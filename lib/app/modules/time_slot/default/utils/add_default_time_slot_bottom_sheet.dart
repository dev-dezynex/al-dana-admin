import 'package:al_dana_admin/app/data/models/list_days.dart';
import 'package:al_dana_admin/app/modules/time_slot/default/providers/default_time_slot_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<dynamic> addDefaultTimeSlotBottomSheet(
  BuildContext context,
  double height,
  double width,
  Future<ListDays> futureListDays,
) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      final List<String> hourOptions = [
        '01',
        '02',
        '03',
        '04',
        '05',
        '06',
        '07',
        '08',
        '09',
        '10',
        '11',
        '12'
      ];
      final List<String> minuteOptions = ['00', '15', '30', '45'];
      final timeData = Provider.of<DefaultProvider>(context);
      final TextEditingController maxBookingController =
          TextEditingController();
      return SizedBox(
        height: height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            const Text(
              'Add Time Slot',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            FutureBuilder<ListDays>(
              future: futureListDays,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Text('Error loading Branch dropdown');
                } else {
                  final listDays = snapshot.data?.data ?? [];
                  return SizedBox(
                    width: 200,
                    child: DropdownButtonFormField<String>(
                      items: listDays.map<DropdownMenuItem<String>>((day) {
                        return DropdownMenuItem<String>(
                          value: day.sId,
                          child: Text(day.day ?? ''),
                        );
                      }).toList(),
                      onChanged: (value) {
                        String selectedDayId = value ?? '';
                        Provider.of<DefaultProvider>(context, listen: false)
                            .setDayId(selectedDayId);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Day',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
                }
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Start Time: '),
                DropdownButton<String>(
                  value: timeData.startTimeHour,
                  items:
                      hourOptions.map<DropdownMenuItem<String>>((String hour) {
                    return DropdownMenuItem<String>(
                        value: hour, child: Text(hour));
                  }).toList(),
                  onChanged: (value) {
                    timeData.startTimeHour = value ?? '00';
                  },
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: timeData.startTimeMinute,
                  items: minuteOptions
                      .map<DropdownMenuItem<String>>((String minute) {
                    return DropdownMenuItem<String>(
                        value: minute, child: Text(minute));
                  }).toList(),
                  onChanged: (value) {
                    timeData.startTimeMinute = value ?? '00';
                  },
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Start Time: '),
                DropdownButton<String>(
                  value: timeData.endTimeHour,
                  items:
                      hourOptions.map<DropdownMenuItem<String>>((String hour) {
                    return DropdownMenuItem<String>(
                        value: hour, child: Text(hour));
                  }).toList(),
                  onChanged: (value) {
                    timeData.endTimeHour = value ?? '00';
                  },
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: timeData.endTimeMinute,
                  items: minuteOptions
                      .map<DropdownMenuItem<String>>((String minute) {
                    return DropdownMenuItem<String>(
                        value: minute, child: Text(minute));
                  }).toList(),
                  onChanged: (value) {
                    timeData.endTimeMinute = value ?? '00';
                  },
                ),
              ],
            ),
            const Spacer(),
            TextFormField(),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                String selectedStartTime = timeData.startTime;
                String selectedEndTime = timeData.endTime;
                print(selectedStartTime);
                print(selectedEndTime);
              },
              child: const Text('Submit'),
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      );
    },
  );
}
