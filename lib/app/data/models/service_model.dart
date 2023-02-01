

import '../data.dart';

class ServiceResult {
  late String status;
  late String message;
  late List<Service> serviceList;

  ServiceResult(
      {this.status = '', this.message = '', this.serviceList = const []});

  ServiceResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      serviceList = <Service>[];
      json['data'].forEach((v) {
        serviceList.add(Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = serviceList.map((v) => v.toJson()).toList();
    return data;
  }
}

class Service {
  late String id;
  late String title;
  late String subTitle;
  late String desc;
  late String image;
  late String bgCardColor;
  late List<Branch> branchList;
  late double price;
  late List<Work> work;
  late SpareCategory spareCategory;

  Service(
      {this.id = '',
      this.title = '',
      this.subTitle = '',
      this.desc = '',
      this.image = '',
      this.bgCardColor = '',
      this.branchList = const [],
      this.price = 0,
      this.work = const [],
      required this.spareCategory});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
    desc = json['desc'];
    image = json['image'];
    bgCardColor = json['bg_card_color'];
    if (json['branch'] != null) {
      branchList = <Branch>[];
      json['branch'].forEach((v) {
        branchList.add(Branch.fromJson(v));
      });
    }
    price = json['price'];
       if (json['works'] != null) {
      work = <Work>[];
      json['works'].forEach((v) {
        work.add(Work.fromJson(v));
      });
    }
    spareCategory = json['spare_category'] != null
        ? SpareCategory.fromJson(json['spare_category'])
        : SpareCategory();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['sub_title'] = subTitle;
    data['desc'] = desc;
    data['image'] = image;
    data['bg_card_color'] = bgCardColor;
    data['branch'] = branchList.map((v) => v.toJson()).toList();
    data['price'] = price;
    data['works'] = work.map((v) => v.toJson()).toList();
    return data;
  }
}
