import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/modules/reports/tabs/booking_tab.dart';
import 'package:al_dana_admin/app/modules/reports/tabs/invoice_tab.dart';
import 'package:al_dana_admin/app/modules/reports/tabs/job_order_tab.dart';
import 'package:al_dana_admin/app/modules/reports/tabs/package_tab.dart';
import 'package:al_dana_admin/app/modules/reports/tabs/subscription_tab.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          title: const Text(
            'Reports',
            style: TextStyle(color: white),
          ),
          backgroundColor: primary,
          bottom: const TabBar(isScrollable: true, tabs: [
            Tab(text: 'Booking'),
            Tab(text: 'Package'),
            Tab(text: 'Job Order'),
            Tab(text: 'Invoice'),
            Tab(text: 'Subscription'),
          ]),
        ),
        body: const TabBarView(children: [
          BookingTab(),
          PackageTab(),
          JobOrderTab(),
          InvoicTab(),
          SubscriptionTab(),
        ]),
      ),
    );
  }
}
