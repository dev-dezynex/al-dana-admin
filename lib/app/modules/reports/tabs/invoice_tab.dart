import 'dart:developer';
import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/modules/reports/models/invoice_report.dart';
import 'package:al_dana_admin/app/modules/reports/providers/invoice_report_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InvoicTab extends StatefulWidget {
  const InvoicTab({super.key});

  @override
  State<InvoicTab> createState() => _InvoicTabState();
}

class _InvoicTabState extends State<InvoicTab> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _currentPage = 1;
  final List<Data> _allInvoiceReports = [];
  bool _isFetched = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();

    _scrollController.addListener(_scrollListener);
  }

  void _loadInitialData() {
    _fetchData(_currentPage.toString());
  }

  void _fetchData(String page) {
    if (_isLoading) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    log('invoice');
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Provider.of<InvoiceReportProvider>(context, listen: false)
            .fetchInvoiceReport(page);
      }
    });
  }

  void _scrollListener() {
    if (!_isLoading &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      _isFetched = false;
      _fetchData(_currentPage.toString());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _allInvoiceReports.clear();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isFetched) {
      final invoiceReports =
          Provider.of<InvoiceReportProvider>(context).invoiceReport?.data;
      if (invoiceReports != null) {
        setState(() {
          _isLoading = false;
          _currentPage++;
          _allInvoiceReports.addAll(invoiceReports);
        });
        _isFetched = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Provider.of<InvoiceReportProvider>(context).isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: primary,
              ),
            )
          : Provider.of<InvoiceReportProvider>(context).hasError
              ? const Center(
                  child: Text('Error loading Invoice Reports'),
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: _allInvoiceReports.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < _allInvoiceReports.length) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          bottom: 10,
                        ),
                        child: Container(
                          height: 160,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Invoice Number',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      ' - ${_allInvoiceReports[index].invoiceNumber}'),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  const Text(
                                    'Booking Id',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' - ${_allInvoiceReports[index].bookingId}',
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  const Text(
                                    'Payment Status',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      ' - ${_allInvoiceReports[index].paymentStatus}'),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  const Text(
                                    'Created on',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      ' - ${DateFormat('dd-MM-yyyy, HH:mm').format(DateTime.parse(_allInvoiceReports[index].createdAt ?? ''))}'),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                      'Updated on - ${DateFormat('dd-MM-yyyy, HH:mm').format(DateTime.parse(_allInvoiceReports[index].updatedAt ?? ''))}'),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: primary,
                              ),
                            )
                          : const SizedBox.shrink();
                    }
                  },
                ),
    );
  }
}
