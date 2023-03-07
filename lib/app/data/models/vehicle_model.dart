import '../data.dart';

class VehicleResult {
  String? status;
  String? message;
  List<Vehicle>? vehicleList;

  VehicleResult({this.status, this.message, this.vehicleList});

  VehicleResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      vehicleList = <Vehicle>[];
      json['data'].forEach((v) {
        vehicleList?.add(Vehicle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = vehicleList?.map((v) => v.toJson()).toList();
    return data;
  }
}

class Vehicle {
  String? id;
  Brand? brand;
  Variant? variant;
  VehicleYear? year;
  VehicleColor? colour;
  String? plateCode;
  String? plateNumber;
  String? image;

  Vehicle(
      {this.id,
      this.brand,
      this.variant,
      this.year,
      this.colour,
      this.plateCode,
      this.plateNumber,
      this.image});

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    brand = json['brand'] != null ? Brand?.fromJson(json['brand']) : null;
    variant =
        json['variant'] != null ? Variant?.fromJson(json['variant']) : null;
    year = json['year'] != null ? VehicleYear?.fromJson(json['year']) : null;
    colour = json['color'] != null ? VehicleColor?.fromJson(json['color']) : null;
    plateCode = json['plate_code'];
    plateNumber = json['plate_number'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    if (brand != null) {
      data['brand'] = brand?.toJson();
    }
    if (variant != null) {
      data['variant'] = variant?.toJson();
    }
    if (year != null) {
      data['year'] = year?.toJson();
    }
    if (colour != null) {
      data['color'] = colour?.toJson();
    }
    data['plate_code'] = plateCode;
    data['plate_number'] = plateNumber;
    data['image'] = image;
    return data;
  }
}

