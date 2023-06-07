import 'package:al_dana_admin/app/modules/time_slot/default/providers/default_time_slot_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/branch_model.dart';
import '../../../../data/providers/branch_provider.dart';

class BranchDropDown extends StatefulWidget {
  const BranchDropDown({
    super.key,
  });

  @override
  State<BranchDropDown> createState() => _BranchDropDownState();
}

class _BranchDropDownState extends State<BranchDropDown> {
  late Future<BranchResult> futureGetBranches;
  @override
  void initState() {
    super.initState();
    futureGetBranches = BranchProvider().getBranches();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BranchResult>(
      future: futureGetBranches,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Text('Error loading Branch dropdown');
        } else {
          final branches = snapshot.data?.branchList ?? [];
          
          return DropdownButtonFormField<String>(
            items: branches.map<DropdownMenuItem<String>>((branch) {
              return DropdownMenuItem<String>(
                value: branch.id,
                child: Text(branch.name),
              );
            }).toList(),
            onChanged: (value) {
              String branchId = value ?? '';
              Provider.of<DefaultProvider>(context, listen: false)
                  .setBranchId(branchId);
              if (branchId != '' || branchId.isNotEmpty) {
                Provider.of<DefaultProvider>(context, listen: false)
                    .setIsBranchSelected(true);
              }
            },
            decoration: const InputDecoration(
              labelText: 'Select Branch',
              border: OutlineInputBorder(),
            ),
          );
        }
      },
    );
  }
}
