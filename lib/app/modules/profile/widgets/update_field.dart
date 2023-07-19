// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/modules/profile/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateFieldButton extends StatelessWidget {
  final TextEditingController controller;
  final String profileId;
  final String labelText;
  final String keyValue;
  const UpdateFieldButton({
    Key? key,
    required this.profileId,
    required this.controller,
    required this.labelText,
    required this.keyValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Update $labelText'),
            content: TextField(
              keyboardType: keyValue == "phoneNumber"
                  ? TextInputType.phone
                  : TextInputType.text,
              controller: controller,
              decoration: InputDecoration(labelText: labelText),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (controller.text.isNotEmpty || controller.text != '') {
                    ProfileProvider()
                        .updateProfile(
                      profileId,
                      keyValue,
                      controller.text,
                    )
                        .then((_) {
                      Navigator.of(context).pop();
                      Provider.of<ProfileProvider>(context, listen: false)
                          .fetchProfile();
                    });
                  }
                  controller.clear();
                },
                child: const Text('Update'),
              ),
            ],
          ),
        );
      },
      child: const Text(
        'Edit',
        style: TextStyle(color: primary),
      ),
    );
  }
}
