// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddressResult {
  String? status;
  String? message;
  List<Address>? data;

  AddressResult({this.status, this.message, this.data});

  AddressResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Address>[];
      json['data'].forEach((v) {
        data?.add(Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  late String sId, addressType, location, landmark, createdAt, updatedAt;
  late double latitude, longitude;
  late bool deletable;
  late int iV;

  Address(
      {this.sId='',
      this.addressType='',
      this.location='',
      this.landmark='',
      this.latitude=0.0,
      this.longitude=0.0,
      this.deletable=false,
      this.createdAt='',
      this.updatedAt='',
      this.iV=0});

  Address.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    addressType = json['addressType'];
    location = json['location'];
    landmark = json['landmark'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deletable = json['deletable'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['addressType'] = addressType;
    data['location'] = location;
    data['landmark'] = landmark;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['deletable'] = deletable;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }

  Address copyWith({
    String? sId,
    String? addressType,
    String? location,
    String? landmark,
    double? latitude,
    double? longitude,
    bool? deletable,
    String? createdAt,
    String? updatedAt,
    int? iV,
  }) {
    return Address(
      sId: sId ?? this.sId,
      addressType: addressType ?? this.addressType,
      location: location ?? this.location,
      landmark: landmark ?? this.landmark,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      deletable: deletable ?? this.deletable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      iV: iV ?? this.iV,
    );
  }
}
