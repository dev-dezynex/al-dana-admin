// ignore_for_file: public_member_api_docs, sort_constructors_first
class CouponResult {
  String? status;
  String? message;
  List<Coupon>? couponList;
  Coupon? coupon;

  CouponResult({this.status, this.message, this.couponList, this.coupon});

  CouponResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    coupon = json['data'] != null ? Coupon.fromJson(json['data']) : Coupon();
  }
  CouponResult.listFromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      couponList = <Coupon>[];
      json['data'].forEach((v) {
        couponList?.add(Coupon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = couponList?.map((v) => v.toJson()).toList();
    return data;
  }
}

class Coupon {
  String? sId;
  String? title;
  String? couponCode;
  double? discountAmount;
  String? couponType;
  double? amount;
  String? startDate;
  String? endDate;
  bool? deletable;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? customerId;

  Coupon({
    this.sId,
    this.title,
    this.couponCode,
    this.discountAmount,
    this.couponType,
    this.amount,
    this.startDate,
    this.endDate,
    this.deletable,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.customerId,
  });

  Coupon.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    couponCode = json['couponCode'];
    discountAmount = double.parse(json['discountAmount'].toString());
    couponType = json['couponType'];
    amount = double.parse(json['amount'].toString());
    startDate = json['startDate'];
    endDate = json['endDate'];
    deletable = json['deletable'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    customerId = json['customerId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['couponCode'] = couponCode;
    data['discountAmount'] = discountAmount;
    data['couponType'] = couponType;
    data['amount'] = amount;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['customerId'] = customerId;
    data['deletable'] = deletable;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }

  Map<String, dynamic> toPost() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['discountAmount'] = discountAmount;
    data['amount'] = amount;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['customerId'] = customerId;
    return data;
  }

  Map<String, dynamic> toUpdate() {
    final data = <String, dynamic>{};
    data['amount'] = amount;
    data['discountAmount'] = discountAmount;
    data['couponType'] = couponType;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    return data;
  }

  Coupon copyWith(
      {String? sId,
      String? title,
      double? discountAmount,
      double? amount,
      String? startDate,
      String? endDate,
      String? customerId,
      String? couponType}) {
    return Coupon(
      sId: sId ?? this.sId,
      title: title ?? this.title,
      discountAmount: discountAmount ?? this.discountAmount,
      amount: amount ?? this.amount,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      couponType: couponType,
      customerId: customerId ?? this.customerId,
    );
  }
}
