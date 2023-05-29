import '../data.dart';

class ServiceResult {
  late String status;
  late String message;
  late List<Service> serviceList;
  Service? service;

  ServiceResult(
      {this.status = '', this.message = '', this.serviceList = const []});

  ServiceResult.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    message = json['message'] ?? '';
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
  late String categoryId, duration, spareCategory;
  // late List<Branch> branchList;
  late double price;
  late int period;
  // late List<String> modeList;
  late List<ServiceDetails> serviceDetails;

  Service({
    this.id = '',
    this.title = '',
    this.desc = '',
    this.image = '',
    this.bgCardColor = '',
    this.categoryId = '',
    this.duration = '',
    this.period = 0,
    // this.branchList = const [],
    this.price = 0,
    this.spareCategory = '',
    this.serviceDetails = const [],
  });

  Service.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    desc = json['description'];
    image = json['image'];
    bgCardColor = json['bg_card_color'];
    categoryId = json['categoryId'] ?? '';
    duration = json['duration'] ?? '';
    period = json['servicePeriod'] ?? 0;
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
    spareCategory = json['spareCategoryId'] ?? '';

    if (json['serviceDetails'] != null) {
      serviceDetails = <ServiceDetails>[];
      json['serviceDetails'].forEach((v) {
        serviceDetails.add(ServiceDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = desc;
    data['image'] = image;
    data['bg_card_color'] = bgCardColor;
    data['categoryId'] = categoryId;
    data['duration'] = duration;
    data['servicePeriod'] = period;
    if (spareCategory.isNotEmpty) {
      data['spareCategoryId'] = spareCategory;
    }
    // data['branch'] = branchList.map((v) => v.toJson()).toList();
    data['price'] = price;
    data['serviceDetails'] = serviceDetails.map((v) => v.toJson()).toList();
    return data;
  }
}

class ServiceDetails {
  String? id, serviceId, branchId;
  List<String>? serviceModeIdList;
  double? price;
  List<ServicePrice>? servicePriceList;

  ServiceDetails({
    this.id,
    this.serviceId,
    this.branchId,
    this.serviceModeIdList,
    this.price,
    this.servicePriceList,
  });

  ServiceDetails.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    serviceId = json['serviceId'];
    branchId = json['branchId'];
    serviceModeIdList = json['serviceModeId'].cast<String>();
    price = double.parse(json['price'].toString());
    if (json['priceArray'] != null) {
      servicePriceList = <ServicePrice>[];
      json['priceArray'].forEach((v) {
        servicePriceList!.add(ServicePrice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['serviceId'] = serviceId;
    data['branchId'] = branchId;
    data['serviceModeId'] = serviceModeIdList;
    data['price'] = price;
    if (servicePriceList != null) {
      data['priceArray'] = servicePriceList!.map((v) => v.toJson()).toList();
    } else {
      data['priceArray'] = [];
    }

    return data;
  }
}

class ServicePrice {
  String? id, serviceDetailId;
  double? price;
  List<String>? variantId, serviceModeId;
  bool? status;

  ServicePrice({
    this.id,
    this.serviceDetailId,
    this.serviceModeId,
    this.variantId,
    this.price,
    this.status,
  });

  ServicePrice.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    serviceDetailId = json['serviceDetailId'];
    serviceModeId = json['serviceModeId'].cast<String>();
    variantId = json['variantId'].cast<String>();
    price = double.parse(json['price'].toString());
    status = json['deletable'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['serviceDetailId'] = serviceDetailId;
    data['serviceModeId'] = serviceModeId;
    data['variantId'] = variantId;
    data['price'] = price;
    data['deletable'] = status;
    return data;
  }
}
