import 'package:flutter/material.dart';

class PackageTab extends StatefulWidget {
  const PackageTab({super.key});

  @override
  State<PackageTab> createState() => _PackageTabState();
}

class _PackageTabState extends State<PackageTab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Package Tab'),
    );
  }
}
