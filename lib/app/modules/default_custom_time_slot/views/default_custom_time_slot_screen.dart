import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/data/providers/custom_time_slot_provider.dart';
import 'package:al_dana_admin/app/data/providers/default_time_slot_provider.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/custom/views/add_custom_time_slot.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/providers/default_custom_time_slot_provider.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/default/views/add_default_time_slot_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom/views/custom_time_view.dart';
import '../default/views/default_time_view.dart';

class DefaultCustomTimeSlotScreen extends StatefulWidget {
  const DefaultCustomTimeSlotScreen({super.key});

  @override
  State<DefaultCustomTimeSlotScreen> createState() =>
      _DefaultCustomTimeSlotScreenState();
}

class _DefaultCustomTimeSlotScreenState
    extends State<DefaultCustomTimeSlotScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DefaultCustomProvider>(context, listen: false).clearAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
          title: const Text('Default & Custom Time Slot'),
          bottom: TabBar(
            indicatorColor: primary2,
            labelColor: Colors.black,
            tabs: const [
              Tab(text: 'Default'),
              Tab(text: 'Custom'),
            ],
            onTap: (value) {
              if (value == 0) {
                Provider.of<CustomTimeSlotProvider>(context, listen: false)
                    .clearCustomTimeslots();
              } else {
                Provider.of<DefaultTimeSlotProvider>(context, listen: false)
                    .clearDefaultTimeslots();
              }
              Provider.of<DefaultCustomProvider>(context, listen: false)
                  .setTabBarIndex(value);
            },
          ),
        ),
        body: const TabBarView(
          children: [
            DefaultTimeSlotView(),
            CustomTimeSlotView(),
          ],
        ),
        floatingActionButton: Consumer<DefaultCustomProvider>(
          builder: (context, tabBar, child) {
            if (tabBar.tabBarIndex == 0) {
              return FloatingActionButton.small(
                backgroundColor: primary,
                onPressed: () {
                  print('Default time slot');
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddDefaultTimeSlotScreen(),
                  ));
                },
                child: const Icon(Icons.add),
              );
            } else {
              return FloatingActionButton.small(
                backgroundColor: primary,
                onPressed: () {
                  print('Custom time slot');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddCustomTimeSlotScreen(),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
