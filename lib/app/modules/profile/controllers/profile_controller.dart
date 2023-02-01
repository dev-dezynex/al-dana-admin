import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/data.dart';

class ProfileController extends GetxController {
  var file = File('').obs;
  var currentUser = Common().currentUser.obs;
  TextEditingController nameController = TextEditingController(text: 'Harps Joseph');
  TextEditingController phoneController = TextEditingController(text: '+974 453875636');
  TextEditingController emailController = TextEditingController(text: 'harpsjoseph@gmail.com');
  TextEditingController addressController = TextEditingController(text: 'Gold Palace, UAE, Baniyas Road Dubai,');
  var isLoading = false.obs;



  @override
  void onClose() {}

  pickImage(ImageSource sourse) async {
    var image = (await FileProvider().pickImage(imageSource: sourse))!;

    print('file picked ${file.value.path.split('/').last}');

    file.value = (await FileProvider().cropImage(image))!;
  }

  void updateProfile() {}
}
