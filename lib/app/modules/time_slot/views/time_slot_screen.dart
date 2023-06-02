import 'package:flutter/material.dart';

import '../custom/views/custom_time_view.dart';
import '../default/views/default_time_view.dart';

class TimeSlotScreen extends StatelessWidget {
  const TimeSlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: const Text('Time Slot'),
          bottom: const TabBar(
            labelColor: Colors.black,
            tabs: [
              Tab(text: 'Default'),
              Tab(text: 'Custom'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DefaultTimeSlotView(),
            CustomTimeSlotView(),
          ],
        ),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
