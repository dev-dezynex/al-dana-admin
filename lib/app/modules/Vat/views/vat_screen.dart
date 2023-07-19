import 'package:al_dana_admin/app/data/data.dart';
import 'package:flutter/material.dart';

class VatScreen extends StatefulWidget {
  const VatScreen({super.key});

  @override
  State<VatScreen> createState() => _VatScreenState();
}

class _VatScreenState extends State<VatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text(
          'Manage VAT',
          style: TextStyle(color: white),
        ),
      ),
    );
  }
}
