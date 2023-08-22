import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/modules/reports/models/package_report.dart';
import 'package:al_dana_admin/app/modules/reports/providers/package_report_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PackageTab extends StatefulWidget {
  const PackageTab({super.key});

  @override
  State<PackageTab> createState() => _PackageTabState();
}

class _PackageTabState extends State<PackageTab> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _currentPage = 1;
  final List<Data> _allPackageReports = [];

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
        Provider.of<PackageReportProvider>(
          context,
          listen: false,
        ).fetchPackageReport(page);
      }
    });
  }

  void _scrollListener() {
    if (!_isLoading &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      _fetchData(_currentPage.toString());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _allPackageReports.clear();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final packageReports =
        Provider.of<PackageReportProvider>(context).packageReport?.data;
    if (packageReports != null) {
      setState(() {
        _isLoading = false;
        _currentPage++;
        _allPackageReports.addAll(packageReports);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Provider.of<PackageReportProvider>(context).isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: primary,
              ),
            )
          : Provider.of<PackageReportProvider>(context).hasError
              ? const Center(
                  child: Text('Error loading Invoice Reports'),
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: _allPackageReports.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < _allPackageReports.length) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          bottom: 10,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Package Title - ${_allPackageReports[index].title}"),
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
