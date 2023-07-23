import 'dart:developer';

import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/modules/Vat/providers/vat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VatScreen extends StatefulWidget {
  const VatScreen({super.key});

  @override
  State<VatScreen> createState() => _VatScreenState();
}

class _VatScreenState extends State<VatScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<VATProvider>(context, listen: false).fetchVAT();
  }

  final TextEditingController vatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vat = Provider.of<VATProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text(
          'Manage VAT',
          style: TextStyle(color: white),
        ),
      ),
      body: vat.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : vat.hasError
              ? const Text('Error loading VAT percentage')
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.builder(
                    itemCount: vat.vatList?.data?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            'Current Vat: ${vat.vatList?.data?[index].percentage}%'),
                        trailing: TextButton(
                          onPressed: () {
                            showBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: vatController,
                                        decoration: const InputDecoration(
                                            labelStyle:
                                                TextStyle(color: primary),
                                            labelText: 'Update VAT %'),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                                foregroundColor: primary),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Cancel',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                                foregroundColor: primary),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              log(vat.vatList?.data?[index]
                                                      .sId ??
                                                  '');
                                              log(vatController.text.trim());
                                              VATProvider()
                                                  .updateVat(
                                                    vat.vatList?.data?[index]
                                                            .sId ??
                                                        '',
                                                    vatController.text.trim(),
                                                  )
                                                  .then(
                                                    (_) => Provider.of<
                                                                VATProvider>(
                                                            context,
                                                            listen: false)
                                                        .fetchVAT(),
                                                  );
                                            },
                                            child: const Text(
                                              'Update',
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text('Edit'),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
