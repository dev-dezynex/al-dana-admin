import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static setup() async {
    try {
      await Permission.contacts.request();
      await Permission.camera.request();
      await Permission.microphone.request();
      await Permission.phone.request();

      if (Platform.isAndroid) {
        await Permission.storage.request();
        // await Permission.manageExternalStorage.request();
        await Permission.accessMediaLocation.request();
        // await Permission.requestInstallPackages.request();
      } else {
         await Permission.photos.request();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "${e.toString()} ");
    }
  }
}
