import 'package:al_dana_admin/app/data/models/default_time_slot.dart';
import 'package:al_dana_admin/app/data/providers/default_time_slot_provider.dart';
import 'package:al_dana_admin/app/modules/time_slot/default/providers/default_time_slot_provider.dart';
import 'package:al_dana_admin/app/modules/time_slot/default/utils/category_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../utils/branch_drop_down.dart';

class DefaultTimeSlotView extends StatefulWidget {
  const DefaultTimeSlotView({super.key});

  @override
  State<DefaultTimeSlotView> createState() => _DefaultTimeSlotViewState();
}

class _DefaultTimeSlotViewState extends State<DefaultTimeSlotView> {
  final TextEditingController _dateController = TextEditingController();
  Future<DefaultTimeSlot>? futureDefaultTimeSlot;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      final String formattedDate = formatter.format(selectedDate);
      _dateController.text = formattedDate;
      if (!mounted) return;
      Provider.of<DefaultProvider>(context, listen: false)
          .setPickedDate(formattedDate);
      Provider.of<DefaultProvider>(context, listen: false)
          .setIsDatePicked(true);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DefaultTimeSlotProvider>(context, listen: false)
          .clearDefaultTimeslots();
      Provider.of<DefaultProvider>(context, listen: false)
          .setIsBranchSelected(false);
      Provider.of<DefaultProvider>(context, listen: false)
          .setIsCategorySelected(false);
      Provider.of<DefaultProvider>(context, listen: false)
          .setIsDatePicked(false);
      Provider.of<DefaultProvider>(context, listen: false).setBranchId('');
      Provider.of<DefaultProvider>(context, listen: false).setCategoryId('');
      Provider.of<DefaultProvider>(context, listen: false).setPickedDate('');
      Provider.of<DefaultProvider>(context, listen: false).setIsLoading(false);
      Provider.of<DefaultProvider>(context, listen: false).startTimeHour = '01';
      Provider.of<DefaultProvider>(context, listen: false).startTimeMinute =
          '00';
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final defaultTimeSlotProvider =
        Provider.of<DefaultTimeSlotProvider>(context);
    bool isBranchSelected =
        Provider.of<DefaultProvider>(context).isBranchSelected;
    bool isCategorySelected =
        Provider.of<DefaultProvider>(context).isCategorySelected;
    String branchId = Provider.of<DefaultProvider>(context).branchId;
    String categoryId = Provider.of<DefaultProvider>(context).categoryId;
    bool isDatePicked = Provider.of<DefaultProvider>(context).isDatePicked;
    bool isLoading = Provider.of<DefaultProvider>(context).isLoading;
    return Padding(
      padding: const EdgeInsets.only(top: 3, left: 10, right: 10, bottom: 8),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          const BranchDropDown(),
          const SizedBox(height: 6),
          const CategroryDropDown(),
          const SizedBox(height: 6),
          TextFormField(
            controller: _dateController,
            onTap: () {
              _selectDate(context);
            },
            decoration: const InputDecoration(
              labelText: 'Select Date',
            ),
            readOnly: true,
          ),
          const SizedBox(height: 6),
          Visibility(
            visible: isBranchSelected && isCategorySelected && isDatePicked,
            child: isLoading
                ? const Center(
                    child: SizedBox(
                        width: 10,
                        height: 10,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        )))
                : Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<DefaultProvider>(context, listen: false)
                            .setIsLoading(true);
                        defaultTimeSlotProvider.fetchTimeSlot(
                          branchId,
                          categoryId,
                          _dateController.text.trim(),
                        );
                        Future.delayed(const Duration(milliseconds: 100), () {
                          Provider.of<DefaultProvider>(context, listen: false)
                              .setIsLoading(false);
                        });
                      },
                      child: const Text('View available time slots'),
                    ),
                  ),
          ),
          Consumer<DefaultTimeSlotProvider>(
            builder: (context, provider, _) {
              if (provider.defaultTimeSlot != null) {
                final timeSlots = provider.defaultTimeSlot!.data;
                return SizedBox(
                  height: height * 0.5,
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
                return const Text(
                    'Failed to load time slot due to backend error');
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
