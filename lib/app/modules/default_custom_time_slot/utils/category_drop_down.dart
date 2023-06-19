import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/providers/default_custom_time_slot_provider.dart';
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
          final width = MediaQuery.of(context).size.width;
          final categories = snapshot.data?.categoryList ?? [];
          return Center(
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
                  items: categories.map<DropdownMenuItem<String>>((category) {
                    return DropdownMenuItem<String>(
                      value: category.id,
                      child: Text(category.title),
                    );
                  }).toList(),
                  onChanged: (value) {
                    String categoryId = value ?? '';
                    Provider.of<DefaultCustomProvider>(context, listen: false)
                        .setCategoryId(categoryId);
                    if (categoryId != '' || categoryId.isNotEmpty) {
                      Provider.of<DefaultCustomProvider>(context, listen: false)
                          .setIsCategorySelected(true);
                    }
                  },
                  decoration:
                      const InputDecoration(hintText: 'Select Category'),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
