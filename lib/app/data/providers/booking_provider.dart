import 'dart:developer';

import 'package:al_dana_admin/app/data/constants/api_routes.dart';
import 'package:get/get.dart';

import '../constants/common.dart';
import '../models/booking_model.dart';

class BookingProvider extends GetConnect {
  Future<BookingResult> getBookingHistory({String date = ""}) async {
    BookingResult result;
    log('With date');
    log(date.toString());

    if (date == "" || date.isEmpty || date == "null") {
      log('without date called');
      final response = await get(
        apiGetListBooking,
        headers: Auth().requestHeaders,
      );
      if (response.statusCode == 200) {
        result = BookingResult.fromJson(response.body);
        log(response.statusCode.toString());
      } else {
        result = BookingResult.fromJson(
            {"status": "error", "message": "Server error !", "data": []});
      }
    } else {
      log('with date called');
      final response = await get(
        "$apiGetListBooking?filter[date]=$date",
        headers: Auth().requestHeaders,
      );
      if (response.statusCode == 200) {
        result = BookingResult.fromJson(response.body);
        log(response.statusCode.toString());
      } else {
        result = BookingResult.fromJson(
            {"status": "error", "message": "Server error !", "data": []});
      }
    }

    return result;
  }

  Future<void> appoveBookingStatus(String status, String bookingId) async {
    final body = <String, dynamic>{
      "approvalStatus": status,
    };
    final response = await put(
      "$apiEditBooking/$bookingId",
      body,
      headers: Auth().requestHeaders,
    );
    if (response.statusCode == 200) {
      Get.snackbar('Sucess', 'Booking Status Changed to "$status"');
    } else {
      Get.snackbar('Failed', 'Failed to update booking status');
    }
  }

  Future<void> assignServiceManager(
    String bookingId,
    String serviceManagerId,
  ) async {
    final body = <String, dynamic>{
      "approvalStatus": "Assigned",
      "serviceManagerId": serviceManagerId,
    };
    final response = await put(
      "$apiEditBooking/$bookingId",
      body,
      headers: Auth().requestHeaders,
    );
    if (response.statusCode == 200) {
      Get.snackbar('Sucess', 'Sucessfully assigned to respective manager');
    } else {
      Get.snackbar('Failed', 'Failed to assign');
    }
  }

  Future<void> assignTechnician(
    String bookingId,
    String technicianId,
  ) async {
    final body = <String, dynamic>{
      "approvalStatus": "Assigned",
      "technicianId": technicianId,
    };
    final response = await put(
      "$apiEditBooking/$bookingId",
      body,
      headers: Auth().requestHeaders,
    );
    if (response.statusCode == 200) {
      Get.snackbar('Sucess', 'Sucessfully assigned to respective manager');
    } else {
      Get.snackbar('Failed', 'Failed to assign');
    }
  }
}
