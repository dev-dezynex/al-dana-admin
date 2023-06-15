import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/data/models/time_slot_model.dart';
import 'package:al_dana_admin/app/data/providers/time_slot_provider.dart';
import 'package:al_dana_admin/app/modules/time_slot/views/add_time_slot_screen.dart';
import 'package:al_dana_admin/app/modules/time_slot/views/edit_time_slot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/time_slot_add_widget.dart';

class TimeSlotScreen extends StatefulWidget {
  const TimeSlotScreen({super.key});

  @override
  State<TimeSlotScreen> createState() => _TimeSlotScreenState();
}

class _TimeSlotScreenState extends State<TimeSlotScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TimeSlotApiProvider>(context, listen: false).clearTimeSlots();
    Provider.of<TimeSlotApiProvider>(context, listen: false).fetchTimeSlots();
    Provider.of<TimeSlotProvider>(context, listen: false).clearAll();
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Time Slot'),
      ),
      body: Consumer<TimeSlotApiProvider>(builder: (context, provider, _) {
        if (provider.timeSlots != null) {
          final timeSlots = provider.timeSlots?.data;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: timeSlots?.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final timeSlot = timeSlots?[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    timeSlotAction(context, timeSlot);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  tileColor: primary,
                  title: Text(
                    '${timeSlot?.startTime} - ${timeSlot?.endTime}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Max Booking: ${timeSlot?.maxBooking}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      if (timeSlot?.status == true)
                        const Text(
                          'Status: Active',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      if (timeSlot?.status == false)
                        const Text(
                          'Status: Inactive',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.hasError) {
          return const Center(
            child: Text('Failed to load time slots due to backend error'),
          );
        } else {
          return const SizedBox();
        }
      }),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: primary2,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTimeSlotScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<String?> timeSlotAction(BuildContext context, Data? timeSlot) {
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Timeslot Action'),
        content: const Text('Do you want to Edit this time slot?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final timeSlotProvider =
                  Provider.of<TimeSlotProvider>(context, listen: false);
              var indexOfColn = timeSlot?.startTime?.indexOf(":");
              timeSlotProvider.startTimeHour =
                  timeSlot?.startTime?.substring(0, indexOfColn) ?? '01';
              timeSlotProvider.startTimeMinute =
                  timeSlot?.startTime?.substring(((indexOfColn ?? 0) + 1)) ??
                      '';

              timeSlotProvider.endTimeHour =
                  timeSlot?.endTime?.substring(0, indexOfColn) ?? '01';
              timeSlotProvider.endTimeMinute =
                  timeSlot?.endTime?.substring((indexOfColn ?? 0) + 1) ?? '';

              Navigator.pop(context, 'OK');
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditTimeSlotScreen(
                  timeSlotId: timeSlot?.sId ?? '',
                  maxBooking: timeSlot?.maxBooking.toString() ?? '',
                ),
              ));
            },
            child: const Text('Edit'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deleteTimeSlot(context, timeSlot);
              },
              child: const Text('Delete')),
        ],
      ),
    );
  }

  Future<dynamic> deleteTimeSlot(BuildContext context, Data? timeSlot) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Timeslot'),
          content: const Text('Do you want to delete this time slot?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                TimeSlotApiProvider().deleteTimeSlot(timeSlot?.sId ?? '').then(
                      (_) => Provider.of<TimeSlotApiProvider>(
                        context,
                        listen: false,
                      ).fetchTimeSlots(),
                    );
                Provider.of<TimeSlotProvider>(context, listen: false)
                    .clearAll();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
