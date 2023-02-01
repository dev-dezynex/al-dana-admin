class VariantResult {
  late String status, message;
  late List<Variant> variantList;

  VariantResult(
      {this.status = '', this.message = '', this.variantList = const []});

  VariantResult.fromJson(Map<String, dynamic> json) {
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
  late String id, name;

  Variant({this.id = '', this.name = ''});

  Variant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
