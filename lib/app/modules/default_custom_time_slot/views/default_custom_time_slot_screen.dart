
import 'package:al_dana_admin/app/data/providers/list_days_provider.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/default/providers/default_time_slot_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/list_days.dart';
import '../custom/views/custom_time_view.dart';
import '../default/utils/add_default_time_slot_bottom_sheet.dart';
import '../default/views/default_time_view.dart';

class DefaultCustomTimeSlotScreen extends StatefulWidget {
  const DefaultCustomTimeSlotScreen({super.key});

  @override
  State<DefaultCustomTimeSlotScreen> createState() =>
      _DefaultCustomTimeSlotScreenState();
}

class _DefaultCustomTimeSlotScreenState
    extends State<DefaultCustomTimeSlotScreen> {
  late Future<ListDays> futureListDays;
  @override
  void initState() {
    super.initState();
    futureListDays = ListDaysProvider.fetchListDays();
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
            labelColor: Colors.black,
            tabs: const [
              Tab(text: 'Default'),
              Tab(text: 'Custom'),
            ],
            onTap: (value) {
              Provider.of<DefaultProvider>(context, listen: false)
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
        floatingActionButton: Consumer<DefaultProvider>(
          builder: (context, tabBar, child) {
            if (tabBar.tabBarIndex == 0) {
              return Visibility(
                visible: tabBar.isBranchSelected && tabBar.isCategorySelected,
                child: FloatingActionButton.small(
                  onPressed: () {
                    addDefaultTimeSlotBottomSheet(
                        context, height, width, futureListDays);
                  },
                  child: const Icon(Icons.add),
                ),
              );
            } else {
              return FloatingActionButton.small(
                onPressed: () {
                  print('Custom time slot');
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
