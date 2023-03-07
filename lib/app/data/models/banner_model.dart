class BannerResult {
  String? status;
  String? message;
  List<BannerModel>? bannerList;
  BannerModel? banner;

  BannerResult({this.status, this.message, this.bannerList});

  BannerResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    banner = json['data'] != null
        ? BannerModel.fromJson(json['data'])
        : BannerModel();
  }

  BannerResult.listFromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      bannerList = <BannerModel>[];
      json['data'].forEach((v) {
        bannerList?.add(BannerModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.bannerList?.map((v) => v.toJson()).toList();
    return data;
  }
}

class BannerModel {
  String? sId;
  String? image;
  bool? deletable;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? branchId;

  BannerModel(
      {this.sId,
      this.image,
      this.deletable,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.branchId});

  BannerModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'];
    deletable = json['deletable'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    branchId = json['branchId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['branchId'] = branchId;
    return data;
  }
}
