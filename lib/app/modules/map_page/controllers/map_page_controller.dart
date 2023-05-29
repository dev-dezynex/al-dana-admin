import 'dart:async';
import 'dart:convert';

import 'package:al_dana_admin/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPageController extends GetxController {
  var isLoading = false.obs;
  Completer<GoogleMapController> mapController = Completer();
  var camPosition = const CameraPosition(
    target: LatLng(9.8959, 76.7184),
    zoom: 14.4746,
  ).obs;
  var markers = <Marker>{}.obs;
  late LocationData currentLocation;
  TextEditingController locationController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();
  Address selectedAddress = Address();
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      selectedAddress = Get.arguments;
      addCurrentLocMarker(
          LatLng(selectedAddress.latitude, selectedAddress.longitude));
      landMarkController.text = selectedAddress.landmark;
    } else {
      getCurrentLocation();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getCurrentLocation() async {
    print("@@@@@@@@@get current location@@@@@@@@");
    Location location = Location();
    currentLocation = await location.getLocation();
    addCurrentLocMarker(
        LatLng(currentLocation.latitude!, currentLocation.longitude!));
    // location.onLocationChanged.listen((loc) {
    //   print("++++++++in location change listener++++++");
    //   if (currentLocation.latitude != loc.latitude &&
    //       currentLocation.longitude != loc.longitude) {
    //     currentLocation = loc;
    //     print("------------in location change listener--------");
    //     addCurrentLocMarker(LatLng(loc.latitude!, loc.longitude!));
    //   }
    // });
  }

  addCurrentLocMarker(LatLng loc) {
    isLoading(true);
    markers.removeWhere((element) => element.markerId.value == 'currentloc');
    Marker resultMarker = Marker(
      markerId: const MarkerId('currentloc'),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: const InfoWindow(title: "your location"),
      position: LatLng(loc.latitude, loc.longitude),
    );
    markers.add(resultMarker);
    markers.refresh;
    moveCamera(loc.latitude, loc.longitude);

    getAddressFromLatLng(loc);
    isLoading(false);
  }

  getAddressFromLatLng(LatLng loc) async {
    List<geo.Placemark> placemarks =
        await geo.placemarkFromCoordinates(loc.latitude, loc.longitude);
    geo.Placemark placemark = placemarks[0];
    String street =
        placemark.street!.isNotEmpty ? '${placemark.street!}, ' : '';
    String subLocality =
        placemark.subLocality!.isNotEmpty ? '${placemark.subLocality!}, ' : '';
    String locality =
        placemark.locality!.isNotEmpty ? '${placemark.locality!}, ' : '';
    String country =
        placemark.country!.isNotEmpty ? '${placemark.country!}  ' : '';
    String address = '$street$subLocality$locality$country';

    locationController.text = address;
    selectedAddress = selectedAddress.copyWith(
        addressType: "BRANCH",
        location: address,
        landmark: landMarkController.text,
        latitude: loc.latitude,
        longitude: loc.longitude);
    print('selectedAddress copywith ${jsonEncode(selectedAddress)}');
    print('selectedAddress ${jsonEncode(selectedAddress)}');
  }

  Future<void> moveCamera(double latitude, double longitude) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14.4746,
    )));
  }

  void search({required String key}) {}

  void onConfirmPressed() {
    print('selectedAddress ${jsonEncode(selectedAddress)}');
    Get.back(
        result: selectedAddress.copyWith(landmark: landMarkController.text));
  }
}
