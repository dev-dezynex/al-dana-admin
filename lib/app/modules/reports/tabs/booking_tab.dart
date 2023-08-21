import 'package:flutter/material.dart';

class BookingTab extends StatefulWidget {
  const BookingTab({super.key});

  @override
  State<BookingTab> createState() => _BookingTabState();
}

class _BookingTabState extends State<BookingTab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Booking tab'),
    );
  }
}
