import 'package:al_dana_admin/app/modules/reports/models/subscription_report.dart';
import 'package:al_dana_admin/app/modules/reports/providers/subscription_report_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/theme/colors.dart';

class SubscriptionTab extends StatefulWidget {
  const SubscriptionTab({super.key});

  @override
  State<SubscriptionTab> createState() => _SubscriptionTabState();
}

class _SubscriptionTabState extends State<SubscriptionTab> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _currentPage = 1;
  final List<Data> _allSubscriptionReports = [];
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
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Provider.of<SubscriptionReportProvider>(
          context,
          listen: false,
        ).fetchSubscriptionReport(page);
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
    _allSubscriptionReports.clear();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isFetched) {
      final subscriptionReports =
          Provider.of<SubscriptionReportProvider>(context)
              .subscriptionReport
              ?.data;
      if (subscriptionReports != null) {
        setState(() {
          _isLoading = false;
          _currentPage++;
          _allSubscriptionReports.addAll(subscriptionReports);
        });
        _isFetched = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Provider.of<SubscriptionReportProvider>(context).isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: primary,
              ),
            )
          : Provider.of<SubscriptionReportProvider>(context).hasError
              ? const Center(
                  child: Text('Error loading Invoice Reports'),
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount:
                      _allSubscriptionReports.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < _allSubscriptionReports.length) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 10),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Booking id - ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${_allSubscriptionReports[index].bookingId}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Subscription Dates',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (_allSubscriptionReports[index].date != [] ||
                                  _allSubscriptionReports[index]
                                      .date!
                                      .isNotEmpty)
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _allSubscriptionReports[index]
                                      .date
                                      ?.length,
                                  itemBuilder: (context, subIndex) {
                                    return Text(
                                        "${subIndex + 1}) ${DateFormat('dd-MM-yyyy, HH:mm').format(
                                      DateTime.parse(
                                          _allSubscriptionReports[index]
                                                  .date?[subIndex] ??
                                              ''),
                                    )}");
                                  },
                                ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Text(
                                    'Created On - ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      " ${DateFormat('dd-MM-yyyy, HH:mm').format(
                                    DateTime.parse(
                                        _allSubscriptionReports[index]
                                                .createdAt ??
                                            ''),
                                  )}")
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Text(
                                    'Updated On - ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      " ${DateFormat('dd-MM-yyyy, HH:mm').format(
                                    DateTime.parse(
                                        _allSubscriptionReports[index]
                                                .updatedAt ??
                                            ''),
                                  )}")
                                ],
                              ),
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
