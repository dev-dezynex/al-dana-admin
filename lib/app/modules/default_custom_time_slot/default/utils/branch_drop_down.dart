import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/default/providers/default_time_slot_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        final width = MediaQuery.of(context).size.width;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Text('Error loading Branch dropdown');
        } else {
          final branches = snapshot.data?.branchList ?? [];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                width: width * 0.7,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      width: 1,
                      color: primary2,
                    ),
                  ),
                  child: DropdownButtonFormField<String>(
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
                    decoration:
                        const InputDecoration(hintText: 'Select Branch'),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
