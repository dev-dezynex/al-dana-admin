// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/data/providers/time_slot_provider.dart';

import '../providers/time_slot_add_widget.dart';

class EditTimeSlotScreen extends StatelessWidget {
  final String timeSlotId;
  final String maxBooking;

  const EditTimeSlotScreen({
    Key? key,
    required this.timeSlotId,
    required this.maxBooking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController maxBookingController =
        TextEditingController(text: maxBooking);
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
            'Edit Time slot',
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
                    onChanged: (String? value) {
                      timeSlotProvider.startTimeMinute = value!;
                    },
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
                  controller: maxBookingController,
                  // onChanged: (value) {
                  //   timeSlotProvider.maxBooking = value;
                  // },
                  decoration: const InputDecoration(
                    labelText: 'Max Booking',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Visibility(
                visible: !Provider.of<TimeSlotApiProvider>(context).isLoading,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: primary),
                  onPressed: () {
                    TimeSlotApiProvider()
                        .updateTimeSlot(
                          timeSlotId,
                          timeSlotProvider.startTime,
                          timeSlotProvider.endTime,
                          maxBookingController.text,
                        )
                        .then(
                          (_) => Provider.of<TimeSlotApiProvider>(
                            context,
                            listen: false,
                          ).fetchTimeSlots(),
                        );
                    Provider.of<TimeSlotProvider>(context, listen: false)
                        .clearAll();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Submit'),
                ),
              ),
              Visibility(
                visible: Provider.of<TimeSlotApiProvider>(context).isLoading,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: primary,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
