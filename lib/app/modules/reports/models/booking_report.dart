class BookingReport {
  String? status;
  String? message;
  List<Data>? data;

  BookingReport({this.status, this.message, this.data});

  BookingReport.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? bookingId;
  BranchId? branchId;
  CustomerId? customerId;
  VehicleId? vehicleId;
  CategoryId? categoryId;
  List<Package>? package;
  String? serviceModeId;
  int? totalAmount;
  int? discountAmount;
  String? approvalStatus;
  String? timeSlotId;
  String? bookingType;
  String? date;
  bool? deletable;
  List<Service>? service;
  List<Spare>? spare;
  String? createdAt;
  String? updatedAt;
  int? iV;
  AddressId? addressId;
  String? serviceManagerId;

  Data(
      {this.sId,
      this.bookingId,
      this.branchId,
      this.customerId,
      this.vehicleId,
      this.categoryId,
      this.package,
      this.serviceModeId,
      this.totalAmount,
      this.discountAmount,
      this.approvalStatus,
      this.timeSlotId,
      this.bookingType,
      this.date,
      this.deletable,
      this.service,
      this.spare,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.addressId,
      this.serviceManagerId});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bookingId = json['bookingId'];
    branchId =
        json['branchId'] != null ? BranchId.fromJson(json['branchId']) : null;
    customerId = json['customerId'] != null
        ? CustomerId.fromJson(json['customerId'])
        : null;
    vehicleId = json['vehicleId'] != null
        ? VehicleId.fromJson(json['vehicleId'])
        : null;
    categoryId = json['categoryId'] != null
        ? CategoryId.fromJson(json['categoryId'])
        : null;
    if (json['package'] != null) {
      package = <Package>[];
      json['package'].forEach((v) {
        package!.add(Package.fromJson(v));
      });
    }
    serviceModeId = json['serviceModeId'];
    totalAmount = json['totalAmount'];
    discountAmount = json['discountAmount'];
    approvalStatus = json['approvalStatus'];
    timeSlotId = json['timeSlotId'];
    bookingType = json['bookingType'];
    date = json['date'];
    deletable = json['deletable'];
    if (json['service'] != null) {
      service = <Service>[];
      json['service'].forEach((v) {
        service!.add(Service.fromJson(v));
      });
    }
    if (json['spare'] != null) {
      spare = <Spare>[];
      json['spare'].forEach((v) {
        spare!.add(Spare.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    addressId = json['addressId'] != null
        ? AddressId.fromJson(json['addressId'])
        : null;
    serviceManagerId = json['serviceManagerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['bookingId'] = bookingId;
    if (branchId != null) {
      data['branchId'] = branchId!.toJson();
    }
    if (customerId != null) {
      data['customerId'] = customerId!.toJson();
    }
    if (vehicleId != null) {
      data['vehicleId'] = vehicleId!.toJson();
    }
    if (categoryId != null) {
      data['categoryId'] = categoryId!.toJson();
    }
    if (package != null) {
      data['package'] = package!.map((v) => v.toJson()).toList();
    }
    data['serviceModeId'] = serviceModeId;
    data['totalAmount'] = totalAmount;
    data['discountAmount'] = discountAmount;
    data['approvalStatus'] = approvalStatus;
    data['timeSlotId'] = timeSlotId;
    data['bookingType'] = bookingType;
    data['date'] = date;
    data['deletable'] = deletable;
    if (service != null) {
      data['service'] = service!.map((v) => v.toJson()).toList();
    }
    if (spare != null) {
      data['spare'] = spare!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    if (addressId != null) {
      data['addressId'] = addressId!.toJson();
    }
    data['serviceManagerId'] = serviceManagerId;
    return data;
  }
}

class BranchId {
  String? sId;
  String? name;
  int? rating;
  String? image;
  bool? deletable;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BranchId(
      {this.sId,
      this.name,
      this.rating,
      this.image,
      this.deletable,
      this.createdAt,
      this.updatedAt,
      this.iV});

  BranchId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    rating = json['rating'];
    image = json['image'];
    deletable = json['deletable'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['rating'] = rating;
    data['image'] = image;
    data['deletable'] = deletable;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class CustomerId {
  String? sId;
  String? name;
  String? password;
  String? email;
  String? phoneNumber;
  String? image;
  String? role;
  bool? deletable;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CustomerId(
      {this.sId,
      this.name,
      this.password,
      this.email,
      this.phoneNumber,
      this.image,
      this.role,
      this.deletable,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CustomerId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    password = json['password'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    image = json['image'];
    role = json['role'];
    deletable = json['deletable'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['password'] = password;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['image'] = image;
    data['role'] = role;
    data['deletable'] = deletable;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class VehicleId {
  Color? color;
  String? sId;
  String? customerId;
  String? carBrandId;
  String? carModelId;
  String? carVariantId;
  String? plateNumber;
  String? image;
  bool? deletable;
  String? createdAt;
  String? updatedAt;
  int? iV;

  VehicleId(
      {this.color,
      this.sId,
      this.customerId,
      this.carBrandId,
      this.carModelId,
      this.carVariantId,
      this.plateNumber,
      this.image,
      this.deletable,
      this.createdAt,
      this.updatedAt,
      this.iV});

  VehicleId.fromJson(Map<String, dynamic> json) {
    color = json['color'] != null ? Color.fromJson(json['color']) : null;
    sId = json['_id'];
    customerId = json['customerId'];
    carBrandId = json['carBrandId'];
    carModelId = json['carModelId'];
    carVariantId = json['carVariantId'];
    plateNumber = json['plateNumber'];
    image = json['image'];
    deletable = json['deletable'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (color != null) {
      data['color'] = color!.toJson();
    }
    data['_id'] = sId;
    data['customerId'] = customerId;
    data['carBrandId'] = carBrandId;
    data['carModelId'] = carModelId;
    data['carVariantId'] = carVariantId;
    data['plateNumber'] = plateNumber;
    data['image'] = image;
    data['deletable'] = deletable;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Color {
  String? name;
  String? code;

  Color({this.name, this.code});

  Color.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}

class CategoryId {
  String? sId;
  String? title;
  String? description;
  String? bgCardColor;
  String? image;
  bool? deletable;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CategoryId(
      {this.sId,
      this.title,
      this.description,
      this.bgCardColor,
      this.image,
      this.deletable,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    bgCardColor = json['bg_card_color'];
    image = json['image'];
    deletable = json['deletable'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['bg_card_color'] = bgCardColor;
    data['image'] = image;
    data['deletable'] = deletable;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Package {
  PackageId? packageId;
  int? packageAmount;
  String? sId;

  Package({this.packageId, this.packageAmount, this.sId});

  Package.fromJson(Map<String, dynamic> json) {
    packageId = json['packageId'] != null
        ? PackageId.fromJson(json['packageId'])
        : null;
    packageAmount = json['packageAmount'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (packageId != null) {
      data['packageId'] = packageId!.toJson();
    }
    data['packageAmount'] = packageAmount;
    data['_id'] = sId;
    return data;
  }
}

class PackageId {
  String? sId;
  String? title;
  String? description;
  String? image;
  int? price;
  String? bgCardColor;
  bool? deletable;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PackageId(
      {this.sId,
      this.title,
      this.description,
      this.image,
      this.price,
      this.bgCardColor,
      this.deletable,
      this.createdAt,
      this.updatedAt,
      this.iV});

  PackageId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    bgCardColor = json['bg_card_color'];
    deletable = json['deletable'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['price'] = price;
    data['bg_card_color'] = bgCardColor;
    data['deletable'] = deletable;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Service {
  ServiceId? serviceId;
  int? serviceAmount;
  String? sId;

  Service({this.serviceId, this.serviceAmount, this.sId});

  Service.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'] != null
        ? ServiceId.fromJson(json['serviceId'])
        : null;
    serviceAmount = json['serviceAmount'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (serviceId != null) {
      data['serviceId'] = serviceId!.toJson();
    }
    data['serviceAmount'] = serviceAmount;
    data['_id'] = sId;
    return data;
  }
}

class ServiceId {
  String? sId;
  String? title;
  String? description;
  String? bgCardColor;
  String? image;
  String? duration;
  String? categoryId;
  int? servicePeriod;
  int? price;
  bool? deletable;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? spareCategoryId;

  ServiceId(
      {this.sId,
      this.title,
      this.description,
      this.bgCardColor,
      this.image,
      this.duration,
      this.categoryId,
      this.servicePeriod,
      this.price,
      this.deletable,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.spareCategoryId});

  ServiceId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    bgCardColor = json['bg_card_color'];
    image = json['image'];
    duration = json['duration'];
    categoryId = json['categoryId'];
    servicePeriod = json['servicePeriod'];
    price = json['price'];
    deletable = json['deletable'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    spareCategoryId = json['spareCategoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['bg_card_color'] = bgCardColor;
    data['image'] = image;
    data['duration'] = duration;
    data['categoryId'] = categoryId;
    data['servicePeriod'] = servicePeriod;
    data['price'] = price;
    data['deletable'] = deletable;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['spareCategoryId'] = spareCategoryId;
    return data;
  }
}

class Spare {
  SpareId? spareId;
  int? spareAmount;
  String? sId;

  Spare({this.spareId, this.spareAmount, this.sId});

  Spare.fromJson(Map<String, dynamic> json) {
    spareId =
        json['spareId'] != null ? SpareId.fromJson(json['spareId']) : null;
    spareAmount = json['spareAmount'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (spareId != null) {
      data['spareId'] = spareId!.toJson();
    }
    data['spareAmount'] = spareAmount;
    data['_id'] = sId;
    return data;
  }
}

class SpareId {
  String? sId;
  String? spareCategoryId;
  String? title;
  int? price;
  int? quantity;
  String? branchId;
  String? image;
  String? description;
  bool? deletable;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SpareId(
      {this.sId,
      this.spareCategoryId,
      this.title,
      this.price,
      this.quantity,
      this.branchId,
      this.image,
      this.description,
      this.deletable,
      this.createdAt,
      this.updatedAt,
      this.iV});

  SpareId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    spareCategoryId = json['spareCategoryId'];
    title = json['title'];
    price = json['price'];
    quantity = json['quantity'];
    branchId = json['branchId'];
    image = json['image'];
    description = json['description'];
    deletable = json['deletable'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['spareCategoryId'] = spareCategoryId;
    data['title'] = title;
    data['price'] = price;
    data['quantity'] = quantity;
    data['branchId'] = branchId;
    data['image'] = image;
    data['description'] = description;
    data['deletable'] = deletable;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class AddressId {
  String? sId;
  String? addressType;
  String? location;
  String? landMark;
  double? latitude;
  double? longitude;
  List<String>? relationId;
  bool? deletable;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AddressId(
      {this.sId,
      this.addressType,
      this.location,
      this.landMark,
      this.latitude,
      this.longitude,
      this.relationId,
      this.deletable,
      this.createdAt,
      this.updatedAt,
      this.iV});

  AddressId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    addressType = json['addressType'];
    location = json['location'];
    landMark = json['landMark'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    relationId = json['relationId'].cast<String>();
    deletable = json['deletable'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['addressType'] = addressType;
    data['location'] = location;
    data['landMark'] = landMark;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['relationId'] = relationId;
    data['deletable'] = deletable;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
