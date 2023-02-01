

import '../data.dart';

class BrandResult {
  late String status, message;
  late List<Brand> brandList;

  BrandResult({this.status = '', this.message = '', this.brandList = const []});

  BrandResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      brandList = <Brand>[];
      json['data'].forEach((v) {
        print('data123 $v');
        brandList.add(Brand.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = brandList.map((v) => v.toJson()).toList();
    return data;
  }
}

class Brand {
  late String id, name, image;
  late List<Variant>? variantList;

  Brand(
      {this.id = '',
      this.name = '',
      this.image = '',
      this.variantList});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['variant'] != null) {
      variantList = <Variant>[];
      json['variant'].forEach((e) {
        variantList?.add(Variant.fromJson(e));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['variant'] = variantList!.map((v) => v.toJson()).toList();
    return data;
  }
}
