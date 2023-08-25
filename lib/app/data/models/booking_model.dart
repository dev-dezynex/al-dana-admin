class BookingResult {
  String? status;
  String? message;
  List<Data>? data;

  BookingResult({this.status, this.message, this.data});

  BookingResult.fromJson(Map<String, dynamic> json) {
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
  BranchId? branchId;
  CustomerId? customerId;
  AddressId? addressId;
  VehicleId? vehicleId;
  CategoryId? categoryId;
  List<Service>? service;
  List<Package>? package;
  List<Spare>? spare;
  ServiceModeId? serviceModeId;
  int? totalAmount;
  int? discountAmount;
  String? approvalStatus;
  TimeSlotId? timeSlotId;
  String? bookingType;
  String? date;
  bool? deletable;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.branchId,
      this.customerId,
      this.addressId,
      this.vehicleId,
      this.categoryId,
      this.service,
      this.package,
      this.spare,
      this.serviceModeId,
      this.totalAmount,
      this.discountAmount,
      this.approvalStatus,
      this.timeSlotId,
      this.bookingType,
      this.date,
      this.deletable,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    branchId =
        json['branchId'] != null ? BranchId.fromJson(json['branchId']) : null;
    customerId = json['customerId'] != null
        ? CustomerId.fromJson(json['customerId'])
        : null;
    addressId = json['addressId'] != null
        ? AddressId.fromJson(json['addressId'])
        : null;
    vehicleId = json['vehicleId'] != null
        ? VehicleId.fromJson(json['vehicleId'])
        : null;
    categoryId = json['categoryId'] != null
        ? CategoryId.fromJson(json['categoryId'])
        : null;
    if (json['service'] != null) {
      service = <Service>[];
      json['service'].forEach((v) {
        service!.add(Service.fromJson(v));
      });
    }
    if (json['package'] != null) {
      package = <Package>[];
      json['package'].forEach((v) {
        package!.add(Package.fromJson(v));
      });
    }
    if (json['spare'] != null) {
      spare = <Spare>[];
      json['spare'].forEach((v) {
        spare!.add(Spare.fromJson(v));
      });
    }
    serviceModeId = json['serviceModeId'] != null
        ? ServiceModeId.fromJson(json['serviceModeId'])
        : null;
    totalAmount = json['totalAmount'];
    discountAmount = json['discountAmount'];
    approvalStatus = json['approvalStatus'];
    timeSlotId = json['timeSlotId'] != null
        ? TimeSlotId.fromJson(json['timeSlotId'])
        : null;
    bookingType = json['bookingType'];
    date = json['date'];
    deletable = json['deletable'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (branchId != null) {
      data['branchId'] = branchId!.toJson();
    }
    if (customerId != null) {
      data['customerId'] = customerId!.toJson();
    }
    if (addressId != null) {
      data['addressId'] = addressId!.toJson();
    }
    if (vehicleId != null) {
      data['vehicleId'] = vehicleId!.toJson();
    }
    if (categoryId != null) {
      data['categoryId'] = categoryId!.toJson();
    }
    if (service != null) {
      data['service'] = service!.map((v) => v.toJson()).toList();
    }
    if (package != null) {
      data['package'] = package!.map((v) => v.toJson()).toList();
    }
    if (spare != null) {
      data['spare'] = spare!.map((v) => v.toJson()).toList();
    }
    if (serviceModeId != null) {
      data['serviceModeId'] = serviceModeId!.toJson();
    }
    data['totalAmount'] = totalAmount;
    data['discountAmount'] = discountAmount;
    data['approvalStatus'] = approvalStatus;
    if (timeSlotId != null) {
      data['timeSlotId'] = timeSlotId!.toJson();
    }
    data['bookingType'] = bookingType;
    data['date'] = date;
    data['deletable'] = deletable;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
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
  List<Services>? services;
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
      this.services,
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
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
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
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    data['deletable'] = deletable;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Services {
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

  Services(
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
      this.iV});

  Services.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Spare {
  String? spareId;
  int? spareAmount;
  String? sId;

  Spare({this.spareId, this.spareAmount, this.sId});

  Spare.fromJson(Map<String, dynamic> json) {
    spareId = json['spareId'];
    spareAmount = json['spareAmount'];
    sId = json['_id'];  
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['spareId'] = spareId;
    data['spareAmount'] = spareAmount;
    data['_id'] = sId;
    return data;
  }
}

class ServiceModeId {
  String? sId;
  String? title;
  String? description;
  String? bgCardColor;
  bool? status;
  bool? needAddress;
  int? price;
  bool? deletable;
  int? iV;

  ServiceModeId(
      {this.sId,
      this.title,
      this.description,
      this.bgCardColor,
      this.status,
      this.needAddress,
      this.price,
      this.deletable,
      this.iV});

  ServiceModeId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    bgCardColor = json['bg_card_color'];
    status = json['status'];
    needAddress = json['needAddress'];
    price = json['price'];
    deletable = json['deletable'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['bg_card_color'] = bgCardColor;
    data['status'] = status;
    data['needAddress'] = needAddress;
    data['price'] = price;
    data['deletable'] = deletable;
    data['__v'] = iV;
    return data;
  }
}

class TimeSlotId {
  String? sId;
  String? startTime;
  String? endTime;
  int? maxBooking;
  bool? status;
  bool? deletable;
  int? iV;

  TimeSlotId(
      {this.sId,
      this.startTime,
      this.endTime,
      this.maxBooking,
      this.status,
      this.deletable,
      this.iV});

  TimeSlotId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    maxBooking = json['maxBooking'];
    status = json['status'];
    deletable = json['deletable'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['maxBooking'] = maxBooking;
    data['status'] = status;
    data['deletable'] = deletable;
    data['__v'] = iV;
    return data;
  }
}


// class BookingResult {
//   String? status;
//   String? message;
//   List<Data>? data;

//   BookingResult({this.status, this.message, this.data});

//   BookingResult.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   String? sId;
//   BranchId? branchId;
//   CustomerId? customerId;
//   VehicleId? vehicleId;
//   CategoryId? categoryId;
//   List<Service>? service;
//   List<Package>? package;
//   List<Spare>? spare;
//   ServiceModeId? serviceModeId;
//   int? totalAmount;
//   int? discountAmount;
//   String? approvalStatus;
//   TimeSlotId? timeSlotId;
//   String? bookingType;
//   String? date;
//   bool? deletable;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   String? addressId;

//   Data(
//       {this.sId,
//       this.branchId,
//       this.customerId,
//       this.vehicleId,
//       this.categoryId,
//       this.service,
//       this.package,
//       this.spare,
//       this.serviceModeId,
//       this.totalAmount,
//       this.discountAmount,
//       this.approvalStatus,
//       this.timeSlotId,
//       this.bookingType,
//       this.date,
//       this.deletable,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.addressId});

//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     branchId = json['branchId'] != null
//         ? BranchId.fromJson(json['branchId'])
//         : null;
//     customerId = json['customerId'] != null
//         ? CustomerId.fromJson(json['customerId'])
//         : null;
//     vehicleId = json['vehicleId'] != null
//         ? VehicleId.fromJson(json['vehicleId'])
//         : null;
//     categoryId = json['categoryId'] != null
//         ? CategoryId.fromJson(json['categoryId'])
//         : null;
//     if (json['service'] != null) {
//       service = <Service>[];
//       json['service'].forEach((v) {
//         service!.add(Service.fromJson(v));
//       });
//     }
//     if (json['package'] != null) {
//       package = <Package>[];
//       json['package'].forEach((v) {
//         package!.add(Package.fromJson(v));
//       });
//     }
//     if (json['spare'] != null) {
//       spare = <Spare>[];
//       json['spare'].forEach((v) {
//         spare!.add(Spare.fromJson(v));
//       });
//     }
//     serviceModeId = json['serviceModeId'] != null
//         ? ServiceModeId.fromJson(json['serviceModeId'])
//         : null;
//     totalAmount = json['totalAmount'];
//     discountAmount = json['discountAmount'];
//     approvalStatus = json['approvalStatus'];
//     timeSlotId = json['timeSlotId'] != null
//         ? TimeSlotId.fromJson(json['timeSlotId'])
//         : null;
//     bookingType = json['bookingType'];
//     date = json['date'];
//     deletable = json['deletable'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     addressId = json['addressId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     if (branchId != null) {
//       data['branchId'] = branchId!.toJson();
//     }
//     if (customerId != null) {
//       data['customerId'] = customerId!.toJson();
//     }
//     if (vehicleId != null) {
//       data['vehicleId'] = vehicleId!.toJson();
//     }
//     if (categoryId != null) {
//       data['categoryId'] = categoryId!.toJson();
//     }
//     if (service != null) {
//       data['service'] = service!.map((v) => v.toJson()).toList();
//     }
//     if (package != null) {
//       data['package'] = package!.map((v) => v.toJson()).toList();
//     }
//     if (spare != null) {
//       data['spare'] = spare!.map((v) => v.toJson()).toList();
//     }
//     if (serviceModeId != null) {
//       data['serviceModeId'] = serviceModeId!.toJson();
//     }
//     data['totalAmount'] = totalAmount;
//     data['discountAmount'] = discountAmount;
//     data['approvalStatus'] = approvalStatus;
//     if (timeSlotId != null) {
//       data['timeSlotId'] = timeSlotId!.toJson();
//     }
//     data['bookingType'] = bookingType;
//     data['date'] = date;
//     data['deletable'] = deletable;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     data['addressId'] = addressId;
//     return data;
//   }
// }

// class BranchId {
//   String? sId;
//   String? name;
//   int? rating;
//   String? image;
//   bool? deletable;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   BranchId(
//       {this.sId,
//       this.name,
//       this.rating,
//       this.image,
//       this.deletable,
//       this.createdAt,
//       this.updatedAt,
//       this.iV});

//   BranchId.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     rating = json['rating'];
//     image = json['image'];
//     deletable = json['deletable'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['name'] = name;
//     data['rating'] = rating;
//     data['image'] = image;
//     data['deletable'] = deletable;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     return data;
//   }
// }

// class CustomerId {
//   String? sId;
//   String? name;
//   String? email;
//   String? phoneNumber;
//   String? image;
//   String? role;
//   bool? deletable;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   CustomerId(
//       {this.sId,
//       this.name,
//       this.email,
//       this.phoneNumber,
//       this.image,
//       this.role,
//       this.deletable,
//       this.createdAt,
//       this.updatedAt,
//       this.iV});

//   CustomerId.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     email = json['email'];
//     phoneNumber = json['phoneNumber'];
//     image = json['image'];
//     role = json['role'];
//     deletable = json['deletable'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['name'] = name;
//     data['email'] = email;
//     data['phoneNumber'] = phoneNumber;
//     data['image'] = image;
//     data['role'] = role;
//     data['deletable'] = deletable;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     return data;
//   }
// }

// class VehicleId {
//   Color? color;
//   String? sId;
//   String? customerId;
//   String? carBrandId;
//   String? carModelId;
//   String? carVariantId;
//   String? plateNumber;
//   String? image;
//   bool? deletable;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   VehicleId(
//       {this.color,
//       this.sId,
//       this.customerId,
//       this.carBrandId,
//       this.carModelId,
//       this.carVariantId,
//       this.plateNumber,
//       this.image,
//       this.deletable,
//       this.createdAt,
//       this.updatedAt,
//       this.iV});

//   VehicleId.fromJson(Map<String, dynamic> json) {
//     color = json['color'] != null ? Color.fromJson(json['color']) : null;
//     sId = json['_id'];
//     customerId = json['customerId'];
//     carBrandId = json['carBrandId'];
//     carModelId = json['carModelId'];
//     carVariantId = json['carVariantId'];
//     plateNumber = json['plateNumber'];
//     image = json['image'];
//     deletable = json['deletable'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (color != null) {
//       data['color'] = color!.toJson();
//     }
//     data['_id'] = sId;
//     data['customerId'] = customerId;
//     data['carBrandId'] = carBrandId;
//     data['carModelId'] = carModelId;
//     data['carVariantId'] = carVariantId;
//     data['plateNumber'] = plateNumber;
//     data['image'] = image;
//     data['deletable'] = deletable;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     return data;
//   }
// }

// class Color {
//   String? name;
//   String? code;

//   Color({this.name, this.code});

//   Color.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     code = json['code'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['code'] = code;
//     return data;
//   }
// }

// class CategoryId {
//   String? sId;
//   String? title;
//   String? description;
//   String? bgCardColor;
//   String? image;
//   bool? deletable;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   CategoryId(
//       {this.sId,
//       this.title,
//       this.description,
//       this.bgCardColor,
//       this.image,
//       this.deletable,
//       this.createdAt,
//       this.updatedAt,
//       this.iV});

//   CategoryId.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     description = json['description'];
//     bgCardColor = json['bg_card_color'];
//     image = json['image'];
//     deletable = json['deletable'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['title'] = title;
//     data['description'] = description;
//     data['bg_card_color'] = bgCardColor;
//     data['image'] = image;
//     data['deletable'] = deletable;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     return data;
//   }
// }

// class Service {
//   ServiceId? serviceId;
//   int? serviceAmount;
//   String? sId;

//   Service({this.serviceId, this.serviceAmount, this.sId});

//   Service.fromJson(Map<String, dynamic> json) {
//     serviceId = json['serviceId'] != null
//         ? ServiceId.fromJson(json['serviceId'])
//         : null;
//     serviceAmount = json['serviceAmount'];
//     sId = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (serviceId != null) {
//       data['serviceId'] = serviceId!.toJson();
//     }
//     data['serviceAmount'] = serviceAmount;
//     data['_id'] = sId;
//     return data;
//   }
// }

// class ServiceId {
//   String? sId;
//   String? title;
//   String? description;
//   String? bgCardColor;
//   String? image;
//   String? duration;
//   String? categoryId;
//   int? servicePeriod;
//   int? price;
//   bool? deletable;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   String? spareCategoryId;

//   ServiceId(
//       {this.sId,
//       this.title,
//       this.description,
//       this.bgCardColor,
//       this.image,
//       this.duration,
//       this.categoryId,
//       this.servicePeriod,
//       this.price,
//       this.deletable,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.spareCategoryId});

//   ServiceId.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     description = json['description'];
//     bgCardColor = json['bg_card_color'];
//     image = json['image'];
//     duration = json['duration'];
//     categoryId = json['categoryId'];
//     servicePeriod = json['servicePeriod'];
//     price = json['price'];
//     deletable = json['deletable'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     spareCategoryId = json['spareCategoryId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['title'] = title;
//     data['description'] = description;
//     data['bg_card_color'] = bgCardColor;
//     data['image'] = image;
//     data['duration'] = duration;
//     data['categoryId'] = categoryId;
//     data['servicePeriod'] = servicePeriod;
//     data['price'] = price;
//     data['deletable'] = deletable;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     data['spareCategoryId'] = spareCategoryId;
//     return data;
//   }
// }

// class Package {
//   PackageId? packageId;
//   int? packageAmount;
//   String? sId;

//   Package({this.packageId, this.packageAmount, this.sId});

//   Package.fromJson(Map<String, dynamic> json) {
//     packageId = json['packageId'] != null
//         ? PackageId.fromJson(json['packageId'])
//         : null;
//     packageAmount = json['packageAmount'];
//     sId = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (packageId != null) {
//       data['packageId'] = packageId!.toJson();
//     }
//     data['packageAmount'] = packageAmount;
//     data['_id'] = sId;
//     return data;
//   }
// }

// class PackageId {
//   String? sId;
//   String? title;
//   String? description;
//   String? image;
//   int? price;
//   String? bgCardColor;
//   List<Services>? services;
//   bool? deletable;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   PackageId(
//       {this.sId,
//       this.title,
//       this.description,
//       this.image,
//       this.price,
//       this.bgCardColor,
//       this.services,
//       this.deletable,
//       this.createdAt,
//       this.updatedAt,
//       this.iV});

//   PackageId.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     description = json['description'];
//     image = json['image'];
//     price = json['price'];
//     bgCardColor = json['bg_card_color'];
//     if (json['services'] != null) {
//       services = <Services>[];
//       json['services'].forEach((v) {
//         services!.add(Services.fromJson(v));
//       });
//     }
//     deletable = json['deletable'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['title'] = title;
//     data['description'] = description;
//     data['image'] = image;
//     data['price'] = price;
//     data['bg_card_color'] = bgCardColor;
//     if (services != null) {
//       data['services'] = services!.map((v) => v.toJson()).toList();
//     }
//     data['deletable'] = deletable;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     return data;
//   }
// }

// class Spare {
//   String? spareId;
//   int? spareAmount;
//   String? sId;

//   Spare({this.spareId, this.spareAmount, this.sId});

//   Spare.fromJson(Map<String, dynamic> json) {
//     spareId = json['spareId'];
//     spareAmount = json['spareAmount'];
//     sId = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['spareId'] = spareId;
//     data['spareAmount'] = spareAmount;
//     data['_id'] = sId;
//     return data;
//   }
// }

// class ServiceModeId {
//   String? sId;
//   String? title;
//   String? description;
//   String? bgCardColor;
//   bool? status;
//   bool? needAddress;
//   int? price;
//   bool? deletable;
//   int? iV;

//   ServiceModeId(
//       {this.sId,
//       this.title,
//       this.description,
//       this.bgCardColor,
//       this.status,
//       this.needAddress,
//       this.price,
//       this.deletable,
//       this.iV});

//   ServiceModeId.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     description = json['description'];
//     bgCardColor = json['bg_card_color'];
//     status = json['status'];
//     needAddress = json['needAddress'];
//     price = json['price'];
//     deletable = json['deletable'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['title'] = title;
//     data['description'] = description;
//     data['bg_card_color'] = bgCardColor;
//     data['status'] = status;
//     data['needAddress'] = needAddress;
//     data['price'] = price;
//     data['deletable'] = deletable;
//     data['__v'] = iV;
//     return data;
//   }
// }

// class TimeSlotId {
//   String? sId;
//   String? startTime;
//   String? endTime;
//   int? maxBooking;
//   bool? status;
//   bool? deletable;
//   int? iV;

//   TimeSlotId(
//       {this.sId,
//       this.startTime,
//       this.endTime,
//       this.maxBooking,
//       this.status,
//       this.deletable,
//       this.iV});

//   TimeSlotId.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     startTime = json['startTime'];
//     endTime = json['endTime'];
//     maxBooking = json['maxBooking'];
//     status = json['status'];
//     deletable = json['deletable'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['startTime'] = startTime;
//     data['endTime'] = endTime;
//     data['maxBooking'] = maxBooking;
//     data['status'] = status;
//     data['deletable'] = deletable;
//     data['__v'] = iV;
//     return data;
//   }
// }
// class Services {
//   String? sId;
//   String? title;
//   String? description;
//   String? bgCardColor;
//   String? image;
//   String? duration;
//   String? categoryId;
//   int? servicePeriod;
//   int? price;
//   bool? deletable;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   Services(
//       {this.sId,
//       this.title,
//       this.description,
//       this.bgCardColor,
//       this.image,
//       this.duration,
//       this.categoryId,
//       this.servicePeriod,
//       this.price,
//       this.deletable,
//       this.createdAt,
//       this.updatedAt,
//       this.iV});

//   Services.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     description = json['description'];
//     bgCardColor = json['bg_card_color'];
//     image = json['image'];
//     duration = json['duration'];
//     categoryId = json['categoryId'];
//     servicePeriod = json['servicePeriod'];
//     price = json['price'];
//     deletable = json['deletable'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['title'] = title;
//     data['description'] = description;
//     data['bg_card_color'] = bgCardColor;
//     data['image'] = image;
//     data['duration'] = duration;
//     data['categoryId'] = categoryId;
//     data['servicePeriod'] = servicePeriod;
//     data['price'] = price;
//     data['deletable'] = deletable;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     return data;
//   }
// }






















































































































































































































































































































































































































































































































































































































