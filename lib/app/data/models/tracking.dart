class Tracking {
  String? status;
  String? message;
  List<Data>? data;

  Tracking({this.status, this.message, this.data});

  Tracking.fromJson(Map<String, dynamic> json) {
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
  String? trackingStatus;
  String? bookingId;
  String? packageId;
  List<String>? afterImage;
  List<String>? beforeImage;
  bool? deletable;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.trackingStatus,
      this.bookingId,
      this.packageId,
      this.afterImage,
      this.beforeImage,
      this.deletable,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    trackingStatus = json['trackingStatus'];
    bookingId = json['bookingId'];
    packageId = json['packageId'];
    afterImage = json['afterImage'].cast<String>();
    beforeImage = json['beforeImage'].cast<String>();
    deletable = json['deletable'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['trackingStatus'] = trackingStatus;
    data['bookingId'] = bookingId;
    data['packageId'] = packageId;
    data['afterImage'] = afterImage;
    data['beforeImage'] = beforeImage;
    data['deletable'] = deletable;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
