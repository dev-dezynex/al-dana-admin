import 'package:al_dana_admin/app/data/providers/list_days_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/theme/colors.dart';
import '../providers/default_time_slot_provider.dart';

class ListDaysDropdown extends StatefulWidget {
  const ListDaysDropdown({super.key});

  @override
  State<ListDaysDropdown> createState() => _ListDaysDropdownState();
}

class _ListDaysDropdownState extends State<ListDaysDropdown> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ListDaysProvider>(context, listen: false).fetchListDays();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ListDaysProvider>(
      builder: (context, provider, _) {
        final width = MediaQuery.of(context).size.width;
        if (provider.listDays != null) {
          final listDays = provider.listDays?.data ?? [];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                width: width * 0.7,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      width: 1,
                      color: primary2,
                    ),
                  ),
                  child: DropdownButtonFormField<String>(
                    items: listDays.map<DropdownMenuItem<String>>((listDay) {
                      return DropdownMenuItem<String>(
                        value: listDay.sId,
                        child: Text(listDay.day ?? ''),
                      );
                    }).toList(),
                    onChanged: (value) {
                      String listDayId = value ?? '';
                      Provider.of<DefaultProvider>(context, listen: false)
                          .setListDayId(listDayId);
                      if (listDayId != '' || listDayId.isNotEmpty) {
                        Provider.of<DefaultProvider>(context, listen: false)
                            .setIsListDaySelected(true);
                      }
                    },
                    decoration: const InputDecoration(hintText: 'Select Day'),
                  ),
                ),
              ),
            ),
          );
        } else if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.hasError) {
          return const Center(
            child: Text('Failed to load Time slot Dropdown'),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
