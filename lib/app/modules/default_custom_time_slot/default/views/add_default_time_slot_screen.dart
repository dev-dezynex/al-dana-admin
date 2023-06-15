import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/data/providers/default_time_slot_provider.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/default/providers/default_time_slot_provider.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/default/utils/branch_drop_down.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/default/utils/category_drop_down.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/default/utils/list_days_drop_down.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/default/utils/time_slot_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDefaultTimeSlotScreen extends StatelessWidget {
  const AddDefaultTimeSlotScreen({super.key});

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
        title: const Text('Add Default Timeslot'),
      ),
      body: Column(
        children: [
          const Spacer(),
          const BranchDropDown(),
          const Spacer(),
          const CategroryDropDown(),
          const Spacer(),
          const ListDaysDropdown(),
          const Spacer(),
          const TimeSlotDropdown(),
          const Spacer(),
          Visibility(
            visible: !Provider.of<DefaultTimeSlotProvider>(context).isLoading,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: primary2,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary2,
                  ),
                  onPressed: () {
                    final defaultProvider =
                        Provider.of<DefaultProvider>(context, listen: false);
                    if (defaultProvider.isBranchSelected &&
                        defaultProvider.isCategorySelected &&
                        defaultProvider.isListDaySelected &&
                        defaultProvider.isTimeSlotSelected) {
                      DefaultTimeSlotProvider()
                          .addDefaultTimeSlot(
                        defaultProvider.branchId,
                        defaultProvider.listDayId,
                        defaultProvider.categoryId,
                        defaultProvider.timeSlotId,
                      )
                          .then(
                        (_) {
                          Provider.of<DefaultTimeSlotProvider>(context,
                                  listen: false)
                              .fetchTimeSlot(
                            defaultProvider.branchId,
                            defaultProvider.categoryId,
                            defaultProvider.listDayId,
                          );
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Visibility(
            visible: Provider.of<DefaultTimeSlotProvider>(context).isLoading,
            child: const Center(
              child: CircularProgressIndicator(
                color: primary,
              ),
            ),
          ),
          const Spacer(),
          const Spacer(flex: 5),
        ],
      ),
    );
  }
}
