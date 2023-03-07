import '../data.dart';

class ServiceResult {
  late String status;
  late String message;
  late List<Service> serviceList;
  Service? service;

  ServiceResult(
      {this.status = '', this.message = '', this.serviceList = const []});

  ServiceResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    service = json['data'] != null ? Service.fromJson(json['data']) : Service();
  }
  ServiceResult.listFromJson(Map<String, dynamic> json) {
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
  late String desc;
  late String image;
  late String bgCardColor;
  late String categoryId;
  // late List<Branch> branchList;
  late double price;
  SpareCategory? spareCategory;
  late List<String> modeList;

  Service({
    this.id = '',
    this.title = '',
    this.desc = '',
    this.image = '',
    this.bgCardColor = '',
    this.categoryId = '',
    // this.branchList = const [],
    this.price = 0,
    this.spareCategory,
    this.modeList = const [],
  });

  Service.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    desc = json['description'];
    image = json['image'];
    bgCardColor = json['bg_card_color'];
    categoryId = json['categoryId']??'';
    // if (json['branch'] != null) {
    //   branchList = <Branch>[];
    //   json['branch'].forEach((v) {
    //     branchList.add(Branch.fromJson(v));
    //   });
    // }
    price = double.parse(json['price'].toString());
    // if (json['serviceModeId'] != null) {
    //   modeList = <ServiceMode>[];
    //   json['serviceModeId'].forEach((v) {
    //     modeList.add(ServiceMode.fromJson(v));
    //   });
    // }
    if (json['spare_category'] != null) {
      spareCategory = SpareCategory.fromJson(json['spare_category']);
    }
    if (json['serviceModeId'] != null) {
      modeList = json['serviceModeId'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = desc;
    data['image'] = image;
    data['bg_card_color'] = bgCardColor;
    data['categoryId'] = categoryId;
    // data['branch'] = branchList.map((v) => v.toJson()).toList();
    data['price'] = price;
    data['serviceModeId'] = modeList;
    return data;
  }
}
