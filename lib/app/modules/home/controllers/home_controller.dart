import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as loc;
import '../../../data/data.dart';
import '../../../data/models/booking_model.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  var common = Common();
  var bottomBarIndex = 1.obs;
  var bannerIndex = 0.obs;
  var categoryResult = CategoryResult().obs;
  TextEditingController vehicleController = TextEditingController();
  loc.LocationData? currentLocation;
  var modeList = <ServiceMode>[].obs;
  var selectedMode = ServiceMode().obs;
  var vehicleList = <Vehicle>[].obs;
  var selectedVehicle = Vehicle().obs;
  //for admin home
  var bookingResult = BookingResult().obs;
  var adminTabIndex = 0.obs;

  //for profile
  var file = File('').obs;
  var currentUser = Common().currentUser.obs;
  TextEditingController nameController =
      TextEditingController(text: 'Harps Joseph');
  TextEditingController phoneController =
      TextEditingController(text: '+974 453875636');
  TextEditingController emailController =
      TextEditingController(text: 'harpsjoseph@gmail.com');
  TextEditingController addressController =
      TextEditingController(text: 'Gold Palace, UAE, Baniyas Road Dubai,');
  var isLoading = false.obs;

  Rx<String> currentAddress = ''.obs;

// Position? _currentPosition;
  @override
  void onInit() {
    super.onInit();
    getDetails();
  }

  @override
  void onClose() {}

  getDetails() {
    // if (common.currentUser.scope == 'admin') {
    getBookings();
    // }
    getService();
    getVehicles();
    getCurrentLocation();
  }

  getService() async {
    categoryResult.value = await CategoryProvider().getCategories();
    categoryResult.refresh();
  }

  getVehicles() async {
    // vehicleList.value = (await VehicleProvider().getDummyData()).vehicleList!;
    // vehicleList.refresh();
  }

  getCurrentLocation() async {
    loc.Location location = loc.Location();
    currentLocation = await location.getLocation();

    getAddressFromLatLng(currentLocation!);

    // location.getLocation().then((loc) => currentLocation = loc);
    // location.onLocationChanged.listen((loc) {
    //   currentLocation = loc;

    //   update();
    // });
  }

  void chooseVehicle(BuildContext context) {
    vehicleSelectionBottomSheet(
        context: context,
        vehicleList: vehicleList,
        selectedVehicle: selectedVehicle,
        onVehicleSelected: (Vehicle vehicle) {
          selectedVehicle.value = vehicle;
          vehicleController.text =
              '${vehicle.brand!.name} - ${vehicle.variant!.title}';
          storage.write(selected_vehicle, vehicle.toJson());
          Get.back();
        });
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        title: Text(
          "Logout",
          style: tsPoppins(color: primary, weight: FontWeight.w600, size: 18),
        ),
        content: Text(
          "Are you sure want to logout ?",
          style:
              tsPoppins(color: textDark40, weight: FontWeight.w400, size: 12),
        ),
        actions: <Widget>[
          TextButton(
            child: Text("cancel",
                style: tsPoppins(
                    color: primary, weight: FontWeight.w400, size: 14)),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: Text("Confirm",
                style: tsPoppins(
                    color: textDark80, weight: FontWeight.w600, size: 14)),
            onPressed: () {
              storage.erase();
              Get.offAllNamed(Routes.AUTH);
            },
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void getBookings() async {
    bookingResult.value = await BookingProvider().getBookingHistory();
    bookingResult.refresh();
  }

  void updateBookingStatus(String bookingStatus, String bookingId) async {
    await BookingProvider()
        .appoveBookingStatus(bookingStatus, bookingId)
        .then((_) => getDetails());
  }

  void assignToServiceManager(String bookingId, String serviceManagerId) async {
    await BookingProvider()
        .assignServiceManager(bookingId, serviceManagerId)
        .then((_) => getDetails());
  }

  void assignToTechnician(String bookingId, String technicianId) async {
    await BookingProvider()
        .assignTechnician(bookingId, technicianId)
        .then((_) => getDetails());
  }
  //for profile

  pickImage(ImageSource sourse) async {
    var image = (await FileProvider().pickImage(imageSource: sourse))!;

    print('file picked ${file.value.path.split('/').last}');

    file.value = (await FileProvider().cropImage(image))!;
  }

  void updateProfile() {}

  // Future<bool> _handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     Get.snackbar(
  //         'Error', 'Location services are disabled. Please enable the services',
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: textDark20,
  //         colorText: textDark80);

  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       Get.snackbar('Error', 'Location permissions are denied',
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: textDark20,
  //           colorText: textDark80);

  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     Get.snackbar('Error',
  //         'Location permissions are permanently denied, we cannot request permissions.',
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: textDark20,
  //         colorText: textDark80);

  //     return false;
  //   }
  //   return true;
  // }

  // Future<void> getCurrentPosition() async {
  //   final hasPermission = await _handleLocationPermission();
  //   if (!hasPermission) return;
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) {
  //     _currentPosition = position;
  //     getAddressFromLatLng(position);
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  Future<void> getAddressFromLatLng(loc.LocationData position) async {
    await placemarkFromCoordinates(position.latitude!, position.longitude!)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress.value = '${place.street}, ${place.subLocality}';
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
