class SpareResult {
  String? status;
  String? message;
  List<Spare>? data;

  SpareResult({this.status, this.message, this.data});

  SpareResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Spare>[];
      json['data'].forEach((v) {
        data?.add(Spare.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data?.map((v) => v.toJson()).toList();
    return data;
  }
}

class Spare {
  String? id;
  String? categoryId;
  String? name;
  double? price;
  String? image;
  int? qty;

  Spare({this.id, this.categoryId, this.name, this.price, this.image,this.qty});

  Spare.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    categoryId = json['category_id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    qty = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    data['quantity'] = qty;
    return data;
  }
}
