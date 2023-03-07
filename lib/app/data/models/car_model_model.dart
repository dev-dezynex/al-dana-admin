class CarModelResult {
  String? status;
  String? message;
  List<CarModel>? carModelList;
  CarModel? carmodel;

  CarModelResult({this.status, this.message, this.carModelList});

  CarModelResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    carmodel =
        json['data'] != null ? CarModel.fromJson(json['data']) : CarModel();
  }

  CarModelResult.listFromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      carModelList = <CarModel>[];
      json['data'].forEach((v) {
        carModelList?.add(CarModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = carModelList?.map((v) => v.toJson()).toList();
    return data;
  }
}

class CarModel {
  String? sId;
  String? title;
  String? description;
  String? image,brandId;
  bool? deletable;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CarModel(
      {this.sId,
      this.title,
      this.description,
      this.image,
      this.brandId,
      this.deletable,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CarModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    brandId = json['carBrandId'];
    deletable = json['deletable'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['carBrandId'] = brandId;
    data['image'] = image;
    return data;
  }
}
