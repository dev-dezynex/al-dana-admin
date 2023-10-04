class SpareList {
  String? status;
  String? message;
  List<Data>? data;

  SpareList({this.status, this.message, this.data});

  SpareList.fromJson(Map<String, dynamic> json) {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
