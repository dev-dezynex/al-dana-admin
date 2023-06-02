import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/modules/time_slot/default/providers/default_time_slot_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategroryDropDown extends StatefulWidget {
  const CategroryDropDown({super.key});

  @override
  State<CategroryDropDown> createState() => _CategroryDropDownState();
}

class _CategroryDropDownState extends State<CategroryDropDown> {
  late Future<CategoryResult> futureGetCategories;

  @override
  void initState() {
    super.initState();
    futureGetCategories = CategoryProvider().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CategoryResult>(
      future: futureGetCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Text('Error in loading category dropdown');
        } else {
          final categories = snapshot.data?.categoryList ?? [];
          return DropdownButtonFormField<String>(
            items: categories.map<DropdownMenuItem<String>>((category) {
              return DropdownMenuItem<String>(
                value: category.id,
                child: Text(category.title),
              );
            }).toList(),
            onChanged: (value) {
              String categoryId = value ?? '';
              Provider.of<DefaultProvider>(context, listen: false)
                  .setCategoryId(categoryId);
              if (categoryId != '' || categoryId.isNotEmpty) {
                Provider.of<DefaultProvider>(context, listen: false)
                    .setIsCategorySelected(true);
              }
            },
            decoration: const InputDecoration(
              labelText: 'Select Category',
              border: OutlineInputBorder(),
            ),
          );
        }
      },
    );
  }
}
