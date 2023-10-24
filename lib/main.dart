import 'package:al_dana_admin/app/data/providers/custom_time_slot_provider.dart';
import 'package:al_dana_admin/app/data/providers/default_time_slot_provider.dart';
import 'package:al_dana_admin/app/data/providers/list_days_provider.dart';
import 'package:al_dana_admin/app/modules/Vat/providers/vat_provider.dart';
import 'package:al_dana_admin/app/modules/extra_charge/provider/extra_charge_provider.dart';
import 'package:al_dana_admin/app/modules/invoice/provider/invoice_provider.dart';
import 'package:al_dana_admin/app/modules/manual_spare_add/provider/manual_spare_category_provider.dart';
import 'package:al_dana_admin/app/modules/profile/providers/profile_provider.dart';
import 'package:al_dana_admin/app/data/providers/time_slot_provider.dart';
import 'package:al_dana_admin/app/modules/default_custom_time_slot/providers/default_custom_time_slot_provider.dart';
import 'package:al_dana_admin/app/modules/reports/providers/booking_report_provider.dart';
import 'package:al_dana_admin/app/modules/reports/providers/invoice_report_provider.dart';
import 'package:al_dana_admin/app/modules/reports/providers/job_report_provider.dart';
import 'package:al_dana_admin/app/modules/reports/providers/package_report_provider.dart';
import 'package:al_dana_admin/app/modules/reports/providers/subscription_report_provider.dart';
import 'package:al_dana_admin/app/modules/time_slot/providers/time_slot_add_widget.dart';
import 'package:al_dana_admin/app/modules/tracking/providers/tracking_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'app/data/data.dart';
import 'app/modules/extra_charge/provider/service_mode_list_provider.dart';
import 'app/modules/manual_spare_add/provider/manual_spare_provider.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  // OneSignal.shared.setAppId(oneSignalAppId);
  // OneSignal.shared.promptUserForPushNotificationPermission().then(
  //   (accepted) {
  //     log('Accepted permission: $accepted');
  //   },
  // );
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TimeSlotApiProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TimeSlotProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DefaultCustomProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DefaultTimeSlotProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ListDaysProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CustomTimeSlotProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => VATProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TrackingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => InvoiceProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => InvoiceReportProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SubscriptionReportProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PackageReportProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BookingReportProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => JobReportProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExtraChargeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ServiceModeListProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ManualSpareCategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ManualSpareListProvider(),
        ),
      ],
      child: GetMaterialApp(
        title: "Al Dana Admin",
        debugShowCheckedModeBanner: false,
        theme: MyTheme.themeData(isDarkTheme: false, context: context),
        darkTheme: MyTheme.themeData(isDarkTheme: true, context: context),
        themeMode: ThemeMode.light,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        unknownRoute: AppPages.routes[0],
      ),
    );
  }
}
