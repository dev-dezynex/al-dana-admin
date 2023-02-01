import '../data.dart';

class CategoryResult {
  late String status;
  late String message;
  late List<Category> categoryList;

  CategoryResult(
      {this.status = '', this.message = '', this.categoryList = const []});

  CategoryResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      categoryList = <Category>[];
      json['data'].forEach((v) {
        categoryList.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = categoryList.map((v) => v.toJson()).toList();
    return data;
  }
}

class Category {
  late String id;
  late String title, desc, image, bgCardColor;
  late List<ServiceMode> modeList;

  Category(
      {this.id = '',
      this.title = '',
      this.desc = '',
      this.image = '',
      this.bgCardColor = '',
      this.modeList = const [],
      });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    image = json['image'];
    bgCardColor = json['bg_card_color'];
    if (json['service_mode'] != null) {
      modeList = <ServiceMode>[];
      json['service_mode'].forEach((v) {
        modeList.add(ServiceMode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    data['image'] = image;
    data['bg_card_color'] = bgCardColor;
     data['service_mode'] = modeList.map((v) => v.toJson()).toList();
    return data;
  }
}
