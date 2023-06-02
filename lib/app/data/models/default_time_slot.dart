class DefaultTimeSlot {
  String? status;
  String? message;
  List<Data>? data;

  DefaultTimeSlot({this.status, this.message, this.data});

  DefaultTimeSlot.fromJson(Map<String, dynamic> json) {
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
  String? startTime;
  String? endTime;
  int? maxBooking;
  bool? status;
  bool? deletable;
  int? iV;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
      this.startTime,
      this.endTime,
      this.maxBooking,
      this.status,
      this.deletable,
      this.iV,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    maxBooking = json['maxBooking'];
    status = json['status'];
    deletable = json['deletable'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['maxBooking'] = maxBooking;
    data['status'] = status;
    data['deletable'] = deletable;
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
