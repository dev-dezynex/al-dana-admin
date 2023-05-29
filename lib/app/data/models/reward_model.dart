// ignore_for_file: public_member_api_docs, sort_constructors_first
class RewardResult {
  String? status;
  String? message;
  List<Reward>? rewardList;
  Reward? reward;

  RewardResult({this.status, this.message, this.rewardList});

  RewardResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    reward = json['data'] != null ? Reward.fromJson(json['data']) : Reward();
  }

  RewardResult.listFromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      rewardList = <Reward>[];
      json['data'].forEach((v) {
        rewardList?.add(Reward.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = rewardList?.map((v) => v.toJson()).toList();
    return data;
  }
}

class Reward {
  String? sId;
  int? point;
  double? amount;
  double? redeemAmount;
  bool? deletable;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Reward(
      {this.sId,
      this.point,
      this.amount,
      this.redeemAmount,
      this.deletable,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Reward.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    point = json['point'];
    amount = double.parse(json['amount'].toString());
    redeemAmount = double.parse(json['redeemAmount'].toString());
    deletable = json['deletable'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['point'] = point;
    data['amount'] = amount;
    data['redeemAmount'] = redeemAmount;
    data['deletable'] = deletable;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }

  Map<String, dynamic> toPost() {
    final data = <String, dynamic>{};
    data['point'] = point;
    data['amount'] = amount;
    data['redeemAmount'] = redeemAmount;
    return data;
  }

  Reward copyWith({
    String? sId,
    int? point,
    double? amount,
    double? redeemAmount,
  }) {
    return Reward(
      sId: sId ?? this.sId,
      point: point ?? this.point,
      amount: amount ?? this.amount,
      redeemAmount: redeemAmount ?? this.redeemAmount,
    );
  }
}
