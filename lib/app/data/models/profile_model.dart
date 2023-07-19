class Profile {
  String? status;
  String? message;
  Data? data;

  Profile({this.status, this.message, this.data});

  Profile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  String? username;
  String? email;
  String? phoneNumber;
  String? image;
  String? role;

  Data(
      {this.sId,
      this.name,
      this.username,
      this.email,
      this.phoneNumber,
      this.image,
      this.role});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    image = json['image'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['image'] = image;
    data['role'] = role;
    return data;
  }
}
