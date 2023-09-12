import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/modules/reports/models/booking_report.dart';
import 'package:al_dana_admin/app/modules/reports/providers/booking_report_provider.dart';
import 'package:al_dana_admin/app/modules/reports/views/booking_report_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingTab extends StatefulWidget {
  const BookingTab({super.key});

  @override
  State<BookingTab> createState() => _BookingTabState();
}

class _BookingTabState extends State<BookingTab> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _currentPage = 1;
  final List<Data> _allBookingReports = [];
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
        Provider.of<BookingReportProvider>(context, listen: false)
            .fetchBookingReport(page);
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
    _allBookingReports.clear();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isFetched) {
      final bookingReports =
          Provider.of<BookingReportProvider>(context).bookingReport?.data;
      if (bookingReports != null) {
        setState(() {
          _isLoading = false;
          _currentPage++;
          _allBookingReports.addAll(bookingReports);
        });
        _isFetched = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Provider.of<BookingReportProvider>(context).isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: primary,
              ),
            )
          : Provider.of<BookingReportProvider>(context).hasError
              ? const Center(
                  child: Text('Error loading Booking Report'),
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: _allBookingReports.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < _allBookingReports.length) {
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
                                builder: (context) => DetailBookingReport(
                                  bookingReport: _allBookingReports[index],
                                ),
                              ),
                            );
                          },
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
                                      'Booking Id',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        ' - ${_allBookingReports[index].bookingId}')
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Text(
                                      'Branch',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        ' - ${_allBookingReports[index].branchId?.name}')
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Text(
                                      'Customer',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        ' - ${_allBookingReports[index].customerId?.name}')
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
                                        ' - ${_allBookingReports[index].approvalStatus}')
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Text(
                                      'Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' - ${_allBookingReports[index].date?.substring(
                                            0,
                                            _allBookingReports[index]
                                                .date
                                                ?.indexOf('T'),
                                          )}',
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
