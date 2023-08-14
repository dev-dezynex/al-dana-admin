import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static setup() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    try {
      // await Permission.contacts.request();
      // await Permission.camera.request();
      // await Permission.microphone.request();
      // await Permission.phone.request();
      await Permission.location.request();

      if (Platform.isAndroid) {
        if (deviceInfo.version.sdkInt > 32) {
          await Permission.photos.request();
        } else {
          await Permission.storage.request();
        }

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
