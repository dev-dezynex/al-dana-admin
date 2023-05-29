import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'app/data/data.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId(oneSignalAppId);
  OneSignal.shared.promptUserForPushNotificationPermission().then(
    (accepted) {
      log('Accepted permission: $accepted');
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    debugPaintSizeEnabled = false;
    return GetMaterialApp(
      title: "Al Dana Admin",
      debugShowCheckedModeBanner: false,
      theme: MyTheme.themeData(isDarkTheme: false, context: context),
      darkTheme: MyTheme.themeData(isDarkTheme: true, context: context),
      themeMode: ThemeMode.light,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      unknownRoute: AppPages.routes[0],
    );
  }
}
