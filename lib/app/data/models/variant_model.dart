class VariantResult {
  late String status, message;
  late List<Variant> variantList;
  Variant? variant;

  VariantResult({
    this.status = '',
    this.message = '',
    this.variantList = const [],
    this.variant,
  });

  VariantResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    variant = json['data'] != null ? Variant.fromJson(json['data']) : Variant();
  }
  VariantResult.listFromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      variantList = <Variant>[];
      json['data'].forEach((v) {
        variantList.add(Variant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = variantList.map((v) => v.toJson()).toList();
    return data;
  }
}

class Variant {
  late String id, title, image, desc, carModelId;
  late double engineCapacity, engineOilCapacity, gearOilCapacity, tyreSize;

  Variant({
    this.id = '',
    this.title = '',
    this.image = '',
    this.desc = '',
    this.carModelId = '',
    this.engineCapacity = 0,
    this.engineOilCapacity = 0,
    this.gearOilCapacity = 0,
    this.tyreSize = 0,
  });

  Variant.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    image = json['image'];
    desc = json['description'];
    carModelId = json['carModelId'];
    engineCapacity = double.parse(json['engineCapacity'].toString());
    engineOilCapacity = double.parse(json['engineOilCapacity'].toString());
    gearOilCapacity = double.parse(json['gearOilCapacity'].toString());
    tyreSize = double.parse(json['tyreSize'].toString());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['image'] = image;
    data['description'] = desc;
    data['carModelId'] = carModelId;
    data['engineCapacity'] = engineCapacity;
    data['gearOilCapacity'] = gearOilCapacity;
    data['tyreSize'] = tyreSize;
    return data;
  }
}
