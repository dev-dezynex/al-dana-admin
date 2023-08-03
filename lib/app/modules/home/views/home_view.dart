import 'package:al_dana_admin/app/modules/Vat/views/vat_screen.dart';
import 'package:al_dana_admin/app/modules/home/views/admin_home.dart';
import 'package:al_dana_admin/app/modules/time_slot/views/time_slot_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../data/data.dart';
import '../../../routes/app_pages.dart';
import '../../default_custom_time_slot/views/default_custom_time_slot_screen.dart';
import '../../profile/views/profile_screen.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Common common = Common();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bgColor1,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        backgroundColor: bgColor1,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: primary,
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Location',
                  style: tsPoppins(
                      size: 9, weight: FontWeight.w400, color: textDark40),
                ),
                Obx(
                  () => Text(
                    '${controller.currentAddress}',
                    style: tsPoppins(size: 10, color: textDark80),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: textDark80,
              ))
        ],
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          NavHeader(
            name: controller.common.currentUser.name,
            image: controller.common.currentUser.image,
          ),
          // NavItem(
          //   title: "Work Manager",
          //   icon: "assets/icons/ic_nav_announcement.svg",
          //   onTap: () {
          //     Get.back();
          //     Get.toNamed(Routes.WORK);
          //   },
          // ),
          // NavItem(
          //   title: "Brand Manager",
          //   icon: "assets/icons/ic_nav_announcement.svg",
          //   onTap: () {
          //     Get.back();
          //     Get.toNamed(Routes.BRAND);
          //   },
          // ),
          // NavItem(
          //   title: "Vehicle Manager",
          //   icon: "assets/icons/ic_nav_announcement.svg",
          //   onTap: () {
          //     Get.back();
          //     Get.toNamed(Routes.VEHICLE);
          //   },
          // ),
          // NavItem(
          //   title: "Google map",
          //   icon: "assets/icons/ic_nav_announcement.svg",
          //   onTap: () {
          //     Get.back();
          //     //Get.toNamed(Routes.MAP_PAGE);
          //     openMapsSheet(context, 'Location');
          //   },
          // ),
          // NavItem(
          //   title: "My Profile",
          //   icon: "assets/icons/ic_nav_1.svg",
          //   onTap: () {
          //     Get.back();
          //   },
          // ),
          // NavItem(
          //   title: "Subscriptions",
          //   icon: "assets/icons/ic_nav_2.svg",
          //   onTap: () {
          //     Get.back();
          //   },
          // ),
          // NavItem(
          //   title: "My Rides",
          //   icon: "assets/icons/ic_nav_3.svg",
          //   onTap: () {
          //     Get.back();
          //   },
          // ),
          // NavItem(
          //   title: "My Bookings",
          //   icon: "assets/icons/ic_nav_4.svg",
          //   onTap: () {
          //     Get.back();
          //     Get.toNamed(Routes.BOOKING_PAGE);
          //   },
          // ),
          if (common.currentUser.scope == "superAdmin")
            NavItem(
              title: "Manage Branch",
              icon: "assets/icons/ic_nav_4.svg",
              onTap: () {
                Get.back();
                Get.toNamed(Routes.BRANCH_LIST);
              },
            ),
          if (common.currentUser.scope == "superAdmin")
            NavItem(
              title: "Manage Service Mode",
              icon: "assets/icons/ic_nav_4.svg",
              onTap: () {
                Get.back();
                Get.toNamed(Routes.SERVICE_MODE);
              },
            ),
          NavItem(
            title: 'Manage Time Schedules',
            icon: "assets/icons/ic_nav_4.svg",
            onTap: () {
              Get.back();
              Get.to(() => const TimeSlotScreen());
            },
          ),

          NavItem(
            title: "Manage Default & Custom Time slot",
            icon: "assets/icons/ic_nav_4.svg",
            onTap: () {
              Get.back();
              // Get.toNamed(Routes.TIME_SLOTS);
              Get.to(() => const DefaultCustomTimeSlotScreen());
            },
          ),
          NavItem(
            title: 'Manage VAT%',
            icon: "assets/icons/ic_nav_4.svg",
            onTap: () {
              Get.back();
              Get.to(() => const VatScreen());
            },
          ),
          NavItem(
            title: "Manage Users",
            icon: "assets/icons/ic_nav_4.svg",
            onTap: () {
              Get.back();
              Get.toNamed(Routes.USERS);
            },
          ),
          NavItem(
            title: "Manage Vehicle",
            icon: "assets/icons/ic_nav_4.svg",
            onTap: () {
              Get.back();
              Get.toNamed(Routes.VEHICLE);
            },
          ),
          NavItem(
            title: "Manage Banner",
            icon: "assets/icons/ic_nav_4.svg",
            onTap: () {
              Get.back();
              Get.toNamed(Routes.BANNER);
            },
          ),
          NavItem(
            title: "Manage Spare",
            icon: "assets/icons/ic_nav_4.svg",
            onTap: () {
              Get.back();
              Get.toNamed(Routes.SPARE_CATEGORY);
            },
          ),
          NavItem(
            title: "Manage Work",
            icon: "assets/icons/ic_nav_4.svg",
            onTap: () {
              Get.back();
              Get.toNamed(Routes.WORK);
            },
          ),
          NavItem(
            title: "Manage Category",
            icon: "assets/icons/ic_nav_4.svg",
            onTap: () {
              Get.back();
              Get.toNamed(Routes.CATEGORY_LIST);
            },
          ),
          NavItem(
            title: "Manage Service",
            icon: "assets/icons/ic_nav_4.svg",
            onTap: () {
              Get.back();
              Get.toNamed(Routes.SERVICE_LIST);
            },
          ),
          NavItem(
            title: "Manage Package",
            icon: "assets/icons/ic_nav_4.svg",
            onTap: () {
              Get.back();
              Get.toNamed(Routes.PACKAGE_LIST);
            },
          ),
          NavItem(
            title: "Notifications",
            icon: "assets/icons/ic_nav_5.svg",
            onTap: () {
              Get.back();
            },
          ),
          NavItem(
            title: "Rewards",
            icon: "assets/icons/ic_nav_6.svg",
            onTap: () {
              Get.back();
              Get.toNamed(Routes.REWARD);
            },
          ),
          NavItem(
            title: "Manage Coupon",
            icon: "assets/icons/ic_nav_4.svg",
            onTap: () {
              Get.back();
              Get.toNamed(Routes.COUPON);
            },
          ),
          NavItem(
            title: "FAQ",
            icon: "assets/icons/ic_nav_7.svg",
            onTap: () {
              Get.back();
            },
          ),
          NavItem(
            title: "Help Center",
            icon: "assets/icons/ic_nav_8.svg",
            onTap: () {
              Get.back();
            },
          ),
          NavItem(
            title: "Logout",
            icon: "assets/icons/ic_nav_9.svg",
            onTap: () {
              Get.back();
              controller.logout();
            },
          ),
        ],
      )),
      body: Obx(
        () => IndexedStack(
          index: controller.bottomBarIndex.value,
          children: _children,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: 'BOTTOMBAR_INDEX',
          onPressed: () {
            controller.bottomBarIndex.value = 1;
          },
          backgroundColor: primary,
          child: SvgPicture.asset('assets/icons/ic_home.svg')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: Obx(
      //   () => BottomNavigationBar(
      //     type: BottomNavigationBarType.fixed,
      //     selectedIconTheme: const IconThemeData(color: white),
      //     unselectedIconTheme: const IconThemeData(color: textDark40),
      //     selectedLabelStyle:
      //         tsPoppins(color: white, size: 10, weight: FontWeight.w600),
      //     unselectedLabelStyle: tsPoppins(color: textDark40, size: 10),
      //     selectedItemColor: white,
      //     unselectedItemColor: textDark40,
      //     elevation: 200.0,
      //     backgroundColor: primary,
      //     // this will be set when a new tab is tapped
      //     items: [
      //       BottomNavigationBarItem(
      //           icon: SvgPicture.asset(
      //             "assets/icons/ic_bottom_bar_1.svg",
      //             color:
      //                 controller.bottomBarIndex.value == 0 ? white : textDark40,
      //           ),
      //           label: 'Students'),
      //       BottomNavigationBarItem(
      //           icon: SvgPicture.asset(
      //             "assets/icons/ic_bottom_bar_2.svg",
      //             color:
      //                 controller.bottomBarIndex.value == 1 ? white : textDark40,
      //           ),
      //           label: 'Teachers'),
      //       BottomNavigationBarItem(icon: Container(), label: ''),
      //       BottomNavigationBarItem(
      //           icon: SvgPicture.asset(
      //             "assets/icons/ic_bottom_bar_3.svg",
      //             color:
      //                 controller.bottomBarIndex.value == 3 ? white : textDark40,
      //           ),
      //           label: 'SME'),
      //       BottomNavigationBarItem(
      //           icon: SvgPicture.asset(
      //             "assets/icons/ic_bottom_bar_4.svg",
      //             color:
      //                 controller.bottomBarIndex.value == 4 ? white : textDark40,
      //           ),
      //           label: 'Search'),
      //     ],
      //     currentIndex: controller.bottomBarIndex.value,
      //     onTap: (int index) {
      //       controller.bottomBarIndex.value = index;
      //     },
      //   ),
      // ),

      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/ic_bottom_bar_6.svg',
                    height: 18,
                    width: 18,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Home',
                    style: tsPoppins(color: primary),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.bottomBarIndex.value = 2;
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/ic_bottom_bar_5.svg',
                    height: 22,
                    width: 22,
                  ),
                ),
              ],
            ),
          )),
    );
  }

  final List<Widget> _children = [
    Container(),
    const AdminHomeView(),
    // ProfileView(),
    const ProfileScreen()
  ];

  final iconList = <IconData>[
    Icons.brightness_5,
    // Icons.brightness_4,
    // Icons.brightness_6,
    Icons.brightness_7,
  ];
}
