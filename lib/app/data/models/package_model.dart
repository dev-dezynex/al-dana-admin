import 'service_model.dart';

class PackageResult {
  String? status;
  String? message;
  List<PackageModel>? packageList;

  PackageResult({this.status, this.message, this.packageList});

  PackageResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      packageList = <PackageModel>[];
      json['data'].forEach((v) {
        packageList?.add(PackageModel.fromJson(v));
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
  String? title, image, bgCardColor;
  double? price;
  List<Service>? services;

  PackageModel(
      {this.id, this.title, this.services, this.image, this.bgCardColor,this.price});

  PackageModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    image = json['image'];
    price = json['price'];
    bgCardColor = json['bg_card_color'];
    if (json['services'] != null) {
      services = <Service>[];
      json['services'].forEach((v) {
        services?.add(Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['price'] = price;
    data['bg_card_color'] = bgCardColor;
    if (services != null) {
      data['services'] = services?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
