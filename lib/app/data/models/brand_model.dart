import '../data.dart';

class BrandResult {
  late String status, message;
  late List<Brand> brandList;
  Brand? brand;

  BrandResult({this.status = '', this.message = '', this.brandList = const []});

  BrandResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    brand = json['data']!=null? Brand.fromJson(json['data']):Brand();
  }
  BrandResult.listFromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      brandList = <Brand>[];
      json['data'].forEach((v) {
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
  late String id, name, image,desc;

  Brand({this.id = '', this.name = '', this.desc = '', this.image = ''});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['title'];
    desc = json['description'];
    image = json['image'];

  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = name;
    data['description'] = desc;
    data['image'] = image;
    return data;
  }
}
