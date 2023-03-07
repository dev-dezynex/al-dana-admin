import '../data.dart';

class BookingResult {
  String? status;
  String? message;
  List<Booking>? bookingList;

  BookingResult({this.status, this.message, this.bookingList});

  BookingResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      bookingList = <Booking>[];
      json['data'].forEach((v) {
        bookingList?.add(Booking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = bookingList?.map((v) => v.toJson()).toList();
    return data;
  }
}

class Booking {
  String? id;
  String? date;
  String? slot;
  String? approvalStatus;
  List<PackageModel>? packageList;
  List<Service>? services;
  List<Spare>? spares;
  Vehicle? vehicle;
  Branch? branch;
  ServiceMode? mode;
  late bool autoSpareSelect;
  late double price;

  Booking({
    this.id,
    this.date,
    this.slot,
    this.approvalStatus,
    this.packageList,
    this.services,
    this.spares,
    this.vehicle,
    this.branch,
    this.mode,
    this.autoSpareSelect = true,
    this.price = 0.0,
  });

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    date = json['date'];
    slot = json['slot'];
    approvalStatus = json['approval_status'];
    autoSpareSelect = json['auto_spare_select'] ?? true;
    price = json['price'];
    if (json['packages'] != null) {
      packageList = <PackageModel>[];
      json['packages'].forEach((v) {
        packageList?.add(PackageModel.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <Service>[];
      json['services'].forEach((v) {
        services?.add(Service.fromJson(v));
      });
    }
    if (json['spares'] != null) {
      spares = <Spare>[];
      json['spares'].forEach((v) {
        spares?.add(Spare.fromJson(v));
      });
    }
    vehicle =
        json['vehicle'] != null ? Vehicle?.fromJson(json['vehicle']) : null;
    branch = json['branch'] != null ? Branch?.fromJson(json['branch']) : null;
    mode = json['mode'] != null ? ServiceMode?.fromJson(json['mode']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['date'] = date;
    data['slot'] = slot;
    data['auto_spare_select'] = autoSpareSelect;
    data['price'] = price;
    data['approval_status'] = approvalStatus;
    if (packageList != null) {
      data['packages'] = packageList?.map((v) => v.toJson()).toList();
    }
    if (services != null) {
      data['services'] = services?.map((v) => v.toJson()).toList();
    }
    if (spares != null) {
      data['spares'] = spares?.map((v) => v.toJson()).toList();
    }
    if (vehicle != null) {
      data['vehicle'] = vehicle?.toJson();
    }

    if (branch != null) {
      data['branch'] = branch?.toJson();
    }

    if (mode != null) {
      data['mode'] = mode?.toJson();
    }

    return data;
  }

  Map<String, dynamic> inputJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    data['slot'] = slot;
    data['price'] = price;
    data['approval_status'] = approvalStatus;
    if (packageList != null) {
      data['packages'] = packageList?.map((v) => v.id).toList();
    }
    if (services != null) {
      data['services'] = services?.map((v) => v.id).toList();
    }
    if (spares != null) {
      data['spares'] = spares?.map((v) => v.id).toList();
    }
    if (vehicle != null) {
      data['vehicle'] = vehicle?.id;
    }

    if (branch != null) {
      data['branch'] = branch?.id;
    }

    if (mode != null) {
      data['mode'] = mode?.id;
    }
    return data;
  }
}
