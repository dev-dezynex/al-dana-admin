import 'dart:developer';
import 'dart:io';

import 'package:al_dana_admin/app/data/data.dart';
import 'package:al_dana_admin/app/modules/profile/providers/profile_provider.dart';
import 'package:al_dana_admin/app/modules/profile/widgets/update_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final profile = Provider.of<ProfileProvider>(context);
    log('User id');
    log(profile.profile?.data?.sId ?? '');
    log('image url');
    log('$apiBase${profile.profile?.data?.image}');
    return profile.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : profile.hasError
            ? const Center(
                child: Text('Failed to load profile'),
              )
            : SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const Spacer(),
                    const Text(
                      'Profile',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        _pickImage(profile.profile?.data?.sId ?? '');
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: primary,
                            radius: 40,
                            child: CircleAvatar(
                              backgroundColor: white,
                              radius: 38,
                              child: Image.network(
                                '$domainName${profile.profile?.data?.image}',
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                      'assets/images/img_avatar_1.png');
                                },
                              ),
                            ),
                          ),
                          const Positioned(
                            bottom: 8,
                            right: 0,
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: primary,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: white,
                                child: Icon(Icons.edit, size: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: height * 0.5,
                      width: width * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          const Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 10,
                                color: primary,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                profile.profile?.data?.name ?? '',
                                style: const TextStyle(fontSize: 18),
                              ),
                              UpdateFieldButton(
                                profileId: profile.profile?.data?.sId ?? '',
                                controller: nameController,
                                labelText: 'Name',
                                keyValue: 'name',
                              ),
                            ],
                          ),
                          const Divider(thickness: 1),
                          const Spacer(flex: 2),
                          const Text(
                            'User Name',
                            style: TextStyle(
                                fontSize: 10,
                                color: primary,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            profile.profile?.data?.username ?? '',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Divider(thickness: 1),
                          const Spacer(flex: 2),
                          const Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 10,
                                color: primary,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                profile.profile?.data?.email ?? '',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          const Divider(thickness: 1),
                          const Spacer(flex: 2),
                          const Text(
                            'Phone',
                            style: TextStyle(
                                fontSize: 10,
                                color: primary,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                profile.profile?.data?.phoneNumber ?? '',
                                style: const TextStyle(fontSize: 18),
                              ),
                              UpdateFieldButton(
                                profileId: profile.profile?.data?.sId ?? '',
                                controller: phoneNumberController,
                                labelText: 'Phone',
                                keyValue: 'phoneNumber',
                              )
                            ],
                          ),
                          const Divider(thickness: 1),
                          const Spacer(flex: 2),
                          const Text(
                            'Role',
                            style: TextStyle(
                                fontSize: 10,
                                color: primary,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            profile.profile?.data?.role ?? '',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Divider(thickness: 1),
                          const Spacer()
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              );
  }

  Future<void> _pickImage(String profileId) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String image = await ProfileProvider().uploadImageFile(imageFile);
      ProfileProvider().updateProfile(profileId, 'image', image).then(
            (_) => Provider.of<ProfileProvider>(context, listen: false)
                .fetchProfile(),
          );
    }
  }
}
