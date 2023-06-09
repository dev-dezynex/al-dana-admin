import 'package:al_dana_admin/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/time_slot_add_widget.dart';

class AddTimeSlotScreen extends StatelessWidget {
  const AddTimeSlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final timeSlotProvider = Provider.of<TimeSlotProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: const Text(
            'Add Time slot',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Start Time:'),
                  DropdownButton<String>(
                    value: timeSlotProvider.startTimeHour,
                    onChanged: (String? value) {
                      timeSlotProvider.startTimeHour = value!;
                    },
                    items: List.generate(12, (index) {
                      return DropdownMenuItem<String>(
                        value: (index + 1).toString().padLeft(2, '0'),
                        child: Text((index + 1).toString().padLeft(2, '0')),
                      );
                    }),
                  ),
                  const Text(':'),
                  DropdownButton<String>(
                    value: timeSlotProvider.startTimeMinute,
                    items: List.generate(60, (index) {
                      return DropdownMenuItem(
                        value: index.toString().padLeft(2, '0'),
                        child: Text(index.toString().padLeft(2, '0')),
                      );
                    }),
                    onChanged: (String? value) {},
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('End Time:'),
                  DropdownButton<String>(
                    value: timeSlotProvider.endTimeHour,
                    onChanged: (String? value) {
                      timeSlotProvider.endTimeHour = value!;
                    },
                    items: List.generate(12, (index) {
                      return DropdownMenuItem<String>(
                        value: (index + 1).toString().padLeft(2, '0'),
                        child: Text((index + 1).toString().padLeft(2, '0')),
                      );
                    }),
                  ),
                  const Text(':'),
                  DropdownButton<String>(
                    value: timeSlotProvider.endTimeMinute,
                    onChanged: (String? value) {
                      timeSlotProvider.endTimeMinute = value!;
                    },
                    items: List.generate(60, (index) {
                      return DropdownMenuItem<String>(
                        value: index.toString().padLeft(2, '0'),
                        child: Text(index.toString().padLeft(2, '0')),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: 100,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    timeSlotProvider.maxBooking = int.parse(value);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Max Booking',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primary),
                onPressed: () {},
                child: const Text('Submit'),
              ),
            ],
          ),
        ));
  }
}
