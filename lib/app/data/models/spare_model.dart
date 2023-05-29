class SpareResult {
  String? status;
  String? message;
  List<Spare>? spareList;
  Spare? spare;

  SpareResult({this.status, this.message, this.spareList});

  SpareResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    spare = json['data'] != null ? Spare.fromJson(json['data']) : Spare();
  }
  SpareResult.listFromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      spareList = <Spare>[];
      json['data'].forEach((v) {
        spareList?.add(Spare.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.spareList?.map((v) => v.toJson()).toList();
    return data;
  }
}

class Spare {
  late String id;
  late String branchId;
  late String categoryId;
  late String name;
  late String desc;
  late double price;
  late String image;
  late int qty;

  Spare(
      {this.id = '',
      this.branchId = '',
      this.categoryId = '',
      this.name = '',
      this.desc = '',
      this.price = 0.0,
      this.image = '',
      this.qty = 0});

  Spare.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    branchId = json['branchId'] ?? '';
    categoryId = json['spareCategoryId'] ?? '';
    desc = json['description'] ?? '';
    name = json['title'] ?? '';
    price = double.parse(json['price'].toString());
    image = json['image'] ?? '';
    qty = json['quantity'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['branchId'] = branchId;
    data['spareCategoryId'] = categoryId;
    data['title'] = name;
    data['description'] = desc;
    data['price'] = price;
    data['image'] = image;
    data['quantity'] = qty;
    return data;
  }
}
