import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/data/providers/time_slot_provider.dart';
import 'package:al_dana_admin/app/modules/time_slot/views/add_time_slot_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                child: Card(
                  elevation: 6,
                  color: primary,
                  child: ListTile(
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
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
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
}
