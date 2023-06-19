import 'package:al_dana_admin/app/data/providers/custom_time_slot_provider.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/providers/default_custom_time_slot_provider.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/utils/branch_drop_down.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/utils/category_drop_down.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/utils/select_date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/theme/colors.dart';

class CustomTimeSlotView extends StatefulWidget {
  const CustomTimeSlotView({super.key});

  @override
  State<CustomTimeSlotView> createState() => _CustomTimeSlotViewState();
}

class _CustomTimeSlotViewState extends State<CustomTimeSlotView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CustomTimeSlotProvider>(context, listen: false)
          .clearCustomTimeslots();
      Provider.of<DefaultCustomProvider>(context, listen: false)
          .setIsBranchSelected(false);
      Provider.of<DefaultCustomProvider>(context, listen: false)
          .setIsCategorySelected(false);
      Provider.of<DefaultCustomProvider>(context, listen: false)
          .setIsDatePicked(false);
      Provider.of<DefaultCustomProvider>(context, listen: false)
          .setBranchId('');
      Provider.of<DefaultCustomProvider>(context, listen: false)
          .setCategoryId('');
      Provider.of<DefaultCustomProvider>(context, listen: false)
          .setIsLoading(false);
      Provider.of<DefaultCustomProvider>(context, listen: false)
          .resetPickedDate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final customTimeSlotProvider = Provider.of<CustomTimeSlotProvider>(context);
    bool isBranchSelected =
        Provider.of<DefaultCustomProvider>(context).isBranchSelected;
    bool isCategorySelected =
        Provider.of<DefaultCustomProvider>(context).isCategorySelected;
    bool isPickedDate =
        Provider.of<DefaultCustomProvider>(context).isDatePicked;
    String branchId = Provider.of<DefaultCustomProvider>(context).branchId;
    String categoryId = Provider.of<DefaultCustomProvider>(context).categoryId;
    String pickedDate = Provider.of<DefaultCustomProvider>(context).pickedDate;
    bool isLoading = Provider.of<DefaultCustomProvider>(context).isLoading;
    return Padding(
      padding: const EdgeInsets.only(top: 3, left: 10, right: 10, bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BranchDropDown(),
          const SizedBox(height: 6),
          const CategroryDropDown(),
          const SizedBox(height: 6),
          const SelectDate(),
          Visibility(
            visible: isBranchSelected && isCategorySelected & isPickedDate,
            child: isLoading
                ? const Center(
                    child: SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: primary),
                      onPressed: () {
                        Provider.of<DefaultCustomProvider>(context,
                                listen: false)
                            .setIsLoading(true);

                        customTimeSlotProvider.fetchCustomTimeSlot(
                          branchId,
                          categoryId,
                          pickedDate,
                        );
                        Future.delayed(
                          const Duration(milliseconds: 100),
                          () {
                            Provider.of<DefaultCustomProvider>(context,
                                    listen: false)
                                .setIsLoading(false);
                          },
                        );
                      },
                      child: const Text('View available time slots'),
                    ),
                  ),
          ),
          Consumer<CustomTimeSlotProvider>(
            builder: (context, provider, _) {
              if (provider.customTimeSlot != null) {
                final timeSlots = provider.customTimeSlot!.data?.timeSlotId;
                return SizedBox(
                  height: height * 0.4,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: timeSlots?.length,
                    itemBuilder: (context, index) {
                      final timeSlot = timeSlots?[index];
                      return Card(
                        elevation: 6,
                        color: Colors.grey.shade100,
                        child: ListTile(
                          title: Text(
                            '${timeSlot?.startTime} - ${timeSlot?.endTime}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Max Booking: ${timeSlot?.maxBooking}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              if (timeSlot?.status == true)
                                const Text(
                                  'Status: Active',
                                  style: TextStyle(fontSize: 14),
                                ),
                              if (timeSlot?.status == false)
                                const Text(
                                  'Status: Inactive',
                                  style: TextStyle(fontSize: 14),
                                ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Delete'),
                                  content: const Text(
                                      'Do you want to delete this time slot'),
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
                                        CustomTimeSlotProvider()
                                            .deleteCustomTimeSlot(
                                              provider.customTimeSlot?.data
                                                      ?.sId ??
                                                  '',
                                              timeSlot?.sId ?? '',
                                            )
                                            .then(
                                              (_) => customTimeSlotProvider
                                                  .fetchCustomTimeSlot(
                                                branchId,
                                                categoryId,
                                                pickedDate,
                                              ),
                                            );
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (provider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (provider.hasError) {
                return const Center(
                  child: Text('No Data'),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
