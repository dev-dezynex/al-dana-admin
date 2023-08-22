class PackageReport {
  String? status;
  String? message;
  List<Data>? data;

  PackageReport({this.status, this.message, this.data});

  PackageReport.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? description;
  String? image;
  int? price;
  String? bgCardColor;
  List<PackageDetails>? packageDetails;
  List<Services>? services;
  bool? deletable;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.title,
      this.description,
      this.image,
      this.price,
      this.bgCardColor,
      this.packageDetails,
      this.services,
      this.deletable,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    bgCardColor = json['bg_card_color'];
    if (json['packageDetails'] != null) {
      packageDetails = <PackageDetails>[];
      json['packageDetails'].forEach((v) {
        packageDetails!.add(PackageDetails.fromJson(v));
      });
    }
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
    if (packageDetails != null) {
      data['packageDetails'] = packageDetails!.map((v) => v.toJson()).toList();
    }
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

class PackageDetails {
  String? sId;
  String? title;
  String? description;
  String? bgCardColor;
  bool? status;
  bool? needAddress;
  int? price;
  bool? deletable;
  int? iV;

  PackageDetails(
      {this.sId,
      this.title,
      this.description,
      this.bgCardColor,
      this.status,
      this.needAddress,
      this.price,
      this.deletable,
      this.iV});

  PackageDetails.fromJson(Map<String, dynamic> json) {
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
  String? spareCategoryId;

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
      this.iV,
      this.spareCategoryId});

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
