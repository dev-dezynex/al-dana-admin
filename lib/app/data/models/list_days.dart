class ListDays {
  String? status;
  String? message;
  List<Data>? data;

  ListDays({this.status, this.message, this.data});

  ListDays.fromJson(Map<String, dynamic> json) {
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
  String? day;
  bool? deletable;
  int? iV;

  Data({this.sId, this.day, this.deletable, this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    day = json['day'];
    deletable = json['deletable'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['day'] = day;
    data['deletable'] = deletable;
    data['__v'] = iV;
    return data;
  }
}
