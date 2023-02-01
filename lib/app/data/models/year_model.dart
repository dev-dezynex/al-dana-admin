class YearResult {
  String? status;
  String? message;
  List<VehicleYear>? yearList;

  YearResult({this.status, this.message, this.yearList});

  YearResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      yearList = <VehicleYear>[];
      json['data'].forEach((v) {
        yearList?.add(VehicleYear.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = yearList?.map((v) => v.toJson()).toList();
    return data;
  }
}

class VehicleYear {
  String? id;
  String? name;

  VehicleYear({this.id, this.name});

  VehicleYear.fromJson(Map<String, dynamic> json) {
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
