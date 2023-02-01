import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/booking_model.dart';

class BookingProvider extends GetConnect {
  Future<BookingResult> getBookingHistory() async {
    final file =
        await rootBundle.loadString('assets/json/booking_history.json');
    final data = await jsonDecode(file);
    BookingResult result = BookingResult.fromJson(data);
    return result;
  }
}
