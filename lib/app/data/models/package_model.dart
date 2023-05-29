import 'package:al_dana_admin/app/data/models/service_mode_model.dart';

import 'branch_model.dart';
import 'service_model.dart';

class PackageResult {
  String? status;
  String? message;
  List<PackageModel>? packageList;
  PackageModel? packageModel;

  PackageResult({this.status, this.message, this.packageList});

  PackageResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    packageModel = json["data"] != null
        ? PackageModel.fromJson(json["data"])
        : PackageModel();
  }
  PackageResult.listFromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      packageList = <PackageModel>[];
      json['data'].forEach((v) {
        packageList?.add(PackageModel.listFromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = packageList?.map((v) => v.toJson()).toList();
    return data;
  }
}

class PackageModel {
  String? id;
  String? title, desc, image, bgCardColor;
  double? price;
  List<PackageDetails>? packageDetailList;

  PackageModel(
      {this.id,
      this.title,
      this.desc,
      this.packageDetailList,
      this.image,
      this.bgCardColor,
      this.price});

  PackageModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    desc = json['description'];
    image = json['image'];
    price = double.parse(json['price'].toString());
    bgCardColor = json['bg_card_color'];
    if (json['packageDetails'] != null) {
      packageDetailList = <PackageDetails>[];
      json['packageDetails'].forEach((v) {
        packageDetailList?.add(PackageDetails.fromJson(v));
      });
    }
  }

  PackageModel.listFromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    desc = json['description'];
    image = json['image'];
    price = double.parse(json['price'].toString());
    bgCardColor = json['bg_card_color'];
    if (json['packageDetails'] != null) {
      packageDetailList = <PackageDetails>[];
      json['packageDetails'].forEach((v) {
        packageDetailList?.add(PackageDetails.listFromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = desc;
    data['image'] = image;
    data['price'] = price;
    data['bg_card_color'] = bgCardColor;
    if (packageDetailList != null) {
      data['packageDetails'] =
          packageDetailList?.map((v) => v.toJson()).toList();
    } else {
      data['packageDetails'] = [];
    }
    return data;
  }
}

class PackageDetails {
  String? id, packageId, branchId;
  List<Service>? services;
  List<ServiceMode>? serviceModeId;
  double? price;
  Branch? branch;

  PackageDetails(
      {this.id,
      this.packageId,
      this.services,
      this.branchId,
      this.serviceModeId,
      this.price});

  PackageDetails.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    packageId = json['packageId'];
    branchId = json['branchId'];
    price = double.parse(json['price'].toString());

    if (json['serviceModeId'] != null) {
      serviceModeId = <ServiceMode>[];
      json['serviceModeId'].forEach((v) {
        serviceModeId?.add(ServiceMode.fromJson(v));
      });
    }
    if (json['service'] != null) {
      services = <Service>[];
      json['service'].forEach((v) {
        services?.add(Service.fromJson(v));
      });
    }
  }

  PackageDetails.listFromJson(Map<String, dynamic> json) {
    id = json['_id'];
    packageId = json['packageId'];
    price = double.parse(json['price'].toString());
    branch =
        json['branchId'] != null ? Branch.fromJson(json['branchId']) : Branch();
    if (json['serviceModeId'] != null) {
      serviceModeId = <ServiceMode>[];
      json['serviceModeId'].forEach((v) {
        serviceModeId?.add(ServiceMode.fromJson(v));
      });
    }
    if (json['service'] != null) {
      services = <Service>[];
      json['service'].forEach((v) {
        services?.add(Service.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['packageId'] = packageId;
    data['branchId'] = branchId;
    data['price'] = price;
    if (serviceModeId != null) {
      data['serviceModeId'] = serviceModeId?.map((e) => e.id).toList();
    } else {
      data['serviceModeId'] = [];
    }
    if (services != null) {
      data['service'] = services?.map((v) => v.id).toList();
    } else {
      data['service'] = [];
    }
    return data;
  }
}
