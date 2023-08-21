class InvoiceReport {
  String? status;
  String? message;
  List<Data>? data;

  InvoiceReport({this.status, this.message, this.data});

  InvoiceReport.fromJson(Map<String, dynamic> json) {
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
  String? invoiceNumber;
  String? bookingId;
  String? paymentStatus;
  bool? deletable;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.invoiceNumber,
      this.bookingId,
      this.paymentStatus,
      this.deletable,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    invoiceNumber = json['invoiceNumber'];
    bookingId = json['bookingId'];
    paymentStatus = json['paymentStatus'];
    deletable = json['deletable'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['invoiceNumber'] = invoiceNumber;
    data['bookingId'] = bookingId;
    data['paymentStatus'] = paymentStatus;
    data['deletable'] = deletable;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
