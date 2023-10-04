import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/modules/manual_spare_add/provider/manual_spare_category_provider.dart';
import 'package:al_dana_admin/app/modules/manual_spare_add/provider/manual_spare_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManualSpareScreen extends StatefulWidget {
  const ManualSpareScreen({super.key});

  @override
  State<ManualSpareScreen> createState() => _ManualSpareScreenState();
}

class _ManualSpareScreenState extends State<ManualSpareScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ManualSpareCategoryProvider>(context, listen: false)
        .getListSpareCategory();
    Provider.of<ManualSpareCategoryProvider>(context, listen: false)
        .setIsSpareCateogrySelected(false);
    Provider.of<ManualSpareCategoryProvider>(context, listen: false)
        .setSpareCategoryId('');
    Provider.of<ManualSpareListProvider>(context, listen: false)
        .setIsSpareSelected(false);
    Provider.of<ManualSpareListProvider>(context, listen: false).setSpareId('');
  }

  @override
  Widget build(BuildContext context) {
    final spareCategory = Provider.of<ManualSpareCategoryProvider>(context);
    final spareList = Provider.of<ManualSpareListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text(
          'Add Spare',
          style: TextStyle(color: white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            if (spareCategory.isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: primary,
                ),
              ),
            if (spareCategory.hasError)
              const Text('Error loading spare category drop down'),
            if (!spareCategory.hasError && !spareCategory.isLoading)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    width: 1,
                    color: primary2,
                  ),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(hintText: 'Spare Category'),
                  items: spareCategory.spareCategoryResult?.data
                      ?.map((spareCategory) {
                    return DropdownMenuItem<String>(
                      value: spareCategory.sId,
                      child: Text(spareCategory.name ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      Provider.of<ManualSpareCategoryProvider>(context,
                              listen: false)
                          .setIsSpareCateogrySelected(true);
                      Provider.of<ManualSpareListProvider>(context,
                              listen: false)
                          .getSpareList(value);

                      Provider.of<ManualSpareCategoryProvider>(context,
                              listen: false)
                          .setSpareCategoryId(value);
                    }
                  },
                ),
              ),
            if (spareCategory.isSpareCategorySelected) const Spacer(),
            Visibility(
              visible: spareCategory.isSpareCategorySelected,
              child: spareList.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primary,
                      ),
                    )
                  : spareList.hasError
                      ? const Center(
                          child: Text('Error loading spare dropdown'),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              width: 1,
                              color: primary2,
                            ),
                          ),
                          child: DropdownButtonFormField<String>(
                            decoration:
                                const InputDecoration(hintText: 'Spare'),
                            items: spareList.spareList?.data?.map((spare) {
                              return DropdownMenuItem<String>(
                                value: spare.sId,
                                child: Text(spare.title ?? ''),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                Provider.of<ManualSpareListProvider>(context,
                                        listen: false)
                                    .setIsSpareSelected(true);
                                Provider.of<ManualSpareListProvider>(context,
                                        listen: false)
                                    .setSpareId(value);
                              }
                            },
                          ),
                        ),
            ),
            const Spacer(),
            const Spacer(flex: 10)
          ],
        ),
      ),
    );
  }
}
