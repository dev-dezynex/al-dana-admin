import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/modules/home/controllers/home_controller.dart';
import 'package:al_dana_admin/app/modules/manual_spare_add/provider/manual_spare_category_provider.dart';
import 'package:al_dana_admin/app/modules/manual_spare_add/provider/manual_spare_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ManualSpareScreen extends StatefulWidget {
  const ManualSpareScreen({
    super.key,
    required this.bookingId,
    required this.totalAmount,
  });
  final String bookingId;
  final String totalAmount;
  @override
  State<ManualSpareScreen> createState() => _ManualSpareScreenState();
}

class _ManualSpareScreenState extends State<ManualSpareScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ManualSpareCategoryProvider>(context, listen: false)
          .getListSpareCategory();
      Provider.of<ManualSpareCategoryProvider>(context, listen: false)
          .setIsSpareCateogrySelected(false);
      Provider.of<ManualSpareCategoryProvider>(context, listen: false)
          .setSpareCategoryId('');
      Provider.of<ManualSpareListProvider>(context, listen: false)
          .setIsSpareSelected(false);
      Provider.of<ManualSpareListProvider>(context, listen: false)
          .setSpareId('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final spareCategory = Provider.of<ManualSpareCategoryProvider>(context);
    final spareList = Provider.of<ManualSpareListProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  decoration:
                      const InputDecoration(hintText: 'Select Spare Category'),
                  items: spareCategory.spareCategoryResult?.data
                      ?.map((spareCategory) {
                    return DropdownMenuItem<String>(
                      value: spareCategory.sId,
                      child: Text(spareCategory.name ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    Provider.of<ManualSpareCategoryProvider>(context,
                            listen: false)
                        .setIsSpareCateogrySelected(false);
                    Provider.of<ManualSpareListProvider>(context, listen: false)
                        .setIsSpareSelected(false);
                    Provider.of<ManualSpareListProvider>(
                      context,
                      listen: false,
                    ).setSpareAmount('');
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
                      _formKey.currentState?.reset();
                    }
                  },
                ),
              ),
            if (spareCategory.isSpareCategorySelected)
              const SizedBox(height: 10),
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
                      : Form(
                          key: _formKey,
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
                              decoration: const InputDecoration(
                                  hintText: 'Select Spare'),
                              items: spareList.spareList?.data?.map((spare) {
                                // Provider.of<ManualSpareListProvider>(
                                //   context,
                                //   listen: false,
                                // ).setSpareAmount(spare.price.toString());
                                return DropdownMenuItem<String>(
                                  value: spare.sId,
                                  child: Text(spare.title ?? ''),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  int selectedIndex = spareList.spareList?.data
                                          ?.indexWhere(
                                              (spare) => spare.sId == value) ??
                                      0;
                                  String selectedSpareAmount = spareList
                                          .spareList?.data?[selectedIndex].price
                                          .toString() ??
                                      '';
                                  Provider.of<ManualSpareListProvider>(context,
                                          listen: false)
                                      .setIsSpareSelected(true);
                                  Provider.of<ManualSpareListProvider>(context,
                                          listen: false)
                                      .setSpareId(value);
                                  Provider.of<ManualSpareListProvider>(
                                    context,
                                    listen: false,
                                  ).setSpareAmount(selectedSpareAmount);
                                }
                              },
                            ),
                          ),
                        ),
            ),
            if (spareList.hasSpareSelected) const SizedBox(height: 10),
            Visibility(
              visible: spareList.hasSpareSelected,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Spare Amount : ${spareList.spareAmount} AED",
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: primary,
                  ))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: primary),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                        ),
                        onPressed: () async {
                          if (spareList.spareAmount != '') {
                            setState(() {
                              _isLoading = true;
                            });
                            await ManualSpareListProvider()
                                .addSpare(
                              widget.bookingId,
                              spareList.spareId,
                              widget.totalAmount,
                              spareList.spareAmount,
                            )
                                .then((_) {
                              setState(() {
                                var controller = Get.find<HomeController>();
                                controller.getDetails();
                                _isLoading = false;
                                Future.delayed(const Duration(seconds: 1), () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                });
                              });
                            });
                          }
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
