import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/modules/reports/models/job_report.dart';
import 'package:al_dana_admin/app/modules/reports/providers/job_report_provider.dart';
import 'package:al_dana_admin/app/modules/reports/views/job_report_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class JobOrderTab extends StatefulWidget {
  const JobOrderTab({super.key});

  @override
  State<JobOrderTab> createState() => _JobOrderTabState();
}

class _JobOrderTabState extends State<JobOrderTab> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _currentPage = 1;
  final List<Data> _allJobReports = [];
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
        Provider.of<JobReportProvider>(context, listen: false)
            .fetchJobReport(page);
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
    _allJobReports.clear();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isFetched) {
      final jobReports =
          Provider.of<JobReportProvider>(context).jobReport?.data;
      if (jobReports != null) {
        setState(() {
          _isLoading = false;
          _currentPage++;
          _allJobReports.addAll(jobReports);
        });
        _isFetched = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Provider.of<JobReportProvider>(context).isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: primary,
              ),
            )
          : Provider.of<JobReportProvider>(context).hasError
              ? const Center(
                  child: Text('Error loading Job Report'),
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: _allJobReports.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < _allJobReports.length) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          bottom: 10,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => JobReportDetailScreen(
                                    jobReport: _allJobReports[index]),
                              ),
                            );
                          },
                          child: Container(
                            height: 200,
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
                                      'Booking Id',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        ' - ${_allJobReports[index].bookingId?.bookingId}')
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Text(
                                      'Branch Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' - ${_allJobReports[index].bookingId?.branchId?.name}'
                                          .capitalize
                                          .toString(),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Text(
                                      'Customer Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' - ${_allJobReports[index].bookingId?.customerId?.name}',
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Text(
                                      'Customer Phone',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' - ${_allJobReports[index].bookingId?.customerId?.phoneNumber}',
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Text(
                                      'Tracking Status',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' - ${_allJobReports[index].trackingStatus}',
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Text(
                                      'Approval Status',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' - ${_allJobReports[index].bookingId?.approvalStatus}',
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Text(
                                      'Total Price',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' - ${_allJobReports[index].bookingId?.totalAmount} AED',
                                    ),
                                  ],
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(color: primary),
                            )
                          : const SizedBox.shrink();
                    }
                  },
                ),
    );
  }
}
