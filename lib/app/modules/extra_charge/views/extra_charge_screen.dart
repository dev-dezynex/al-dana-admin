import 'dart:developer';

import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/modules/extra_charge/provider/extra_charge_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/service_mode_list_provider.dart';

class ExtraChargeScreen extends StatefulWidget {
  const ExtraChargeScreen({super.key});

  @override
  State<ExtraChargeScreen> createState() => _ExtraChargeScreenState();
}

class _ExtraChargeScreenState extends State<ExtraChargeScreen> {
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ServiceModeListProvider>(context, listen: false)
          .fetchServiceModeList();
      Provider.of<ExtraChargeProvider>(context, listen: false)
          .fetchExtraCharge();
      Provider.of<ServiceModeListProvider>(context, listen: false)
          .setServiceModeId('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final extraChargeProvider = Provider.of<ExtraChargeProvider>(context);
    final serviceListProvider = Provider.of<ServiceModeListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Extra Charge',
          style: TextStyle(color: white),
        ),
        backgroundColor: primary,
      ),
      body: extraChargeProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : extraChargeProvider.hasError
              ? const Center(
                  child: Text('Error'),
                )
              : ListView.builder(
                  itemCount: extraChargeProvider.extraCharge?.data?.length,
                  itemBuilder: (context, index) {
                    return ExtraChargeTile(
                      extraChargeProvider: extraChargeProvider,
                      serviceModeListProvider: serviceListProvider,
                      index: index,
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          distanceController.clear();
          amountController.clear();
          Provider.of<ServiceModeListProvider>(context, listen: false)
              .setServiceModeId('');
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 12),
                        if (serviceListProvider.isLoading)
                          const Center(
                            child: CircularProgressIndicator(
                              color: primary,
                            ),
                          ),
                        if (serviceListProvider.hasError)
                          const Center(
                            child: Text('Error loading Service mode list'),
                          ),
                        if (!serviceListProvider.isLoading &&
                            !serviceListProvider.hasError)
                          DropdownButtonFormField<String>(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a Service mode';
                              }
                              return null;
                            },
                            items: serviceListProvider
                                .serviceModeResult?.serviceModeList
                                ?.map<DropdownMenuItem<String>>((serviceMode) {
                              return DropdownMenuItem<String>(
                                value: serviceMode.id,
                                child: Text(serviceMode.title ?? ''),
                              );
                            }).toList(),
                            onChanged: (value) {
                              String branchId = value ?? '';
                              Provider.of<ServiceModeListProvider>(
                                context,
                                listen: false,
                              ).setServiceModeId(branchId);
                            },
                            decoration: const InputDecoration(
                              labelText: 'Service Mode',
                            ),
                          ),
                        const SizedBox(height: 12),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter minimum distance';
                            }
                            return null;
                          },
                          controller: distanceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Minimum Distance(KM)',
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter amount';
                            }
                            return null;
                          },
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Amount (AED)',
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
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
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.of(context).pop();
                                  Provider.of<ExtraChargeProvider>(context,
                                          listen: false)
                                      .addExtraCharge(
                                        serviceListProvider.serviceModeId,
                                        amountController.text,
                                        distanceController.text,
                                      )
                                      .then(
                                        (_) => Provider.of<ExtraChargeProvider>(
                                                context,
                                                listen: false)
                                            .fetchExtraCharge(),
                                      );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primary),
                              child: const Text('Add'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ExtraChargeTile extends StatefulWidget {
  const ExtraChargeTile({
    super.key,
    required this.extraChargeProvider,
    required this.index,
    required this.serviceModeListProvider,
  });

  final ExtraChargeProvider extraChargeProvider;
  final int index;
  final ServiceModeListProvider serviceModeListProvider;

  @override
  State<ExtraChargeTile> createState() => _ExtraChargeTileState();
}

class _ExtraChargeTileState extends State<ExtraChargeTile> {
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _distanceController.text = widget.extraChargeProvider.extraCharge
            ?.data?[widget.index].minimumDistance ??
        '';
    _amountController.text =
        widget.extraChargeProvider.extraCharge?.data?[widget.index].amount ??
            '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: black,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Service Mode - ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  widget.extraChargeProvider.extraCharge?.data?[widget.index]
                          .serviceModeId?.title ??
                      '',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Minimum Distance - ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "${widget.extraChargeProvider.extraCharge?.data?[widget.index].minimumDistance} Km",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Amount - ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "${widget.extraChargeProvider.extraCharge?.data?[widget.index].amount} AED",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    log('Edit button clicked');
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Edit'),
                          content: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Edit
                                if (widget.serviceModeListProvider.isLoading)
                                  const Center(
                                    child: CircularProgressIndicator(
                                      color: primary,
                                    ),
                                  ),
                                if (widget.serviceModeListProvider.hasError)
                                  const Center(
                                    child:
                                        Text('Error loading Service mode list'),
                                  ),
                                if (!widget.serviceModeListProvider.isLoading &&
                                    !widget.serviceModeListProvider.hasError)
                                  DropdownButtonFormField<String>(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select a Service mode';
                                      }
                                      return null;
                                    },
                                    items: widget.serviceModeListProvider
                                        .serviceModeResult?.serviceModeList
                                        ?.map<DropdownMenuItem<String>>(
                                            (serviceMode) {
                                      return DropdownMenuItem<String>(
                                        value: serviceMode.id,
                                        child: Text(serviceMode.title ?? ''),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      String branchId = value ?? '';
                                      Provider.of<ServiceModeListProvider>(
                                        context,
                                        listen: false,
                                      ).setServiceModeId(branchId);
                                    },
                                    decoration: InputDecoration(
                                      hintText: widget
                                              .extraChargeProvider
                                              .extraCharge
                                              ?.data?[widget.index]
                                              .serviceModeId
                                              ?.title ??
                                          '',
                                    ),
                                  ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter minimum distance';
                                    }
                                    return null;
                                  },
                                  controller: _distanceController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Minimum Distance(KM)',
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter amount';
                                    }
                                    return null;
                                  },
                                  controller: _amountController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Amount (AED)',
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
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
                                    const SizedBox(width: 5),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          Navigator.of(context).pop();
                                          Provider.of<ExtraChargeProvider>(
                                                  context,
                                                  listen: false)
                                              .editExtraCharge(
                                                widget
                                                        .extraChargeProvider
                                                        .extraCharge
                                                        ?.data?[widget.index]
                                                        .sId ??
                                                    '',
                                                widget.serviceModeListProvider
                                                    .serviceModeId,
                                                _amountController.text,
                                                _distanceController.text,
                                              )
                                              .then(
                                                (_) => Provider.of<
                                                            ExtraChargeProvider>(
                                                        context,
                                                        listen: false)
                                                    .fetchExtraCharge(),
                                              );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: primary),
                                      child: const Text('Edit'),
                                    ),
                                  ],
                                ),
                                // Edit
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    children: const [
                      Text(
                        'Edit',
                        style: TextStyle(fontSize: 18, color: primary),
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.edit,
                        size: 18,
                        color: primary,
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<ExtraChargeProvider>(
                      context,
                      listen: false,
                    )
                        .deleteExtraCharge(widget.extraChargeProvider
                                .extraCharge?.data?[widget.index].sId ??
                            '')
                        .then(
                          (_) => Provider.of<ExtraChargeProvider>(context,
                                  listen: false)
                              .fetchExtraCharge(),
                        );
                  },
                  child: Row(
                    children: const [
                      Text(
                        'Delete',
                        style: TextStyle(fontSize: 18, color: Colors.red),
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.delete,
                        size: 18,
                        color: Colors.red,
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
