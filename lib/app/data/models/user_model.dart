class UserResult {
  late String status, message;
  late User user;
  late List<User> userList;

  UserResult({
    this.status = '',
    this.message = '',
    required this.user,
  });

  UserResult.list({
    this.status = '',
    this.message = '',
    this.userList = const [],
  });

  UserResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['data'] != null ? User?.fromJson(json['data']) : User();
  }
  UserResult.listFromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      userList = <User>[];
      json['data'].forEach((v) {
        userList.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = user.toJson();
    return data;
  }

  Map<String, dynamic> listToJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = userList.map((e) => e.toJson()).toList();
    return data;
  }
}

class User {
  late String id, name, email, image, branchId, scope, username, password;
  late String mobile;
  late bool status;

  User(
      {this.id = '',
      this.name = '',
      this.mobile = '',
      this.email = '',
      this.image = '',
      this.branchId = '',
      this.scope = '',
      this.username = '',
      this.password = '',
      this.status = false});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    name = json['name'] ?? '';
    username = json['username'] ?? '';
    password = json['password'] ?? '';
    mobile = json['phoneNumber'] ?? '';
    email = json['email'] ?? '';
    image = json['image'] ?? '';
    branchId = json['branchId'] ?? '';
    scope = json['role'] ?? '';
    status = json['status'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['password'] = password;
    data['phoneNumber'] = mobile;
    data['email'] = email;
    data['image'] = image;
    data['branchId'] = branchId;
    data['role'] = scope;
    data['status'] = status;
    return data;
  }

  Map<String, dynamic> toJsonBody() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['username'] = username;
    data['password'] = password;
    data['phoneNumber'] = mobile;
    data['email'] = email;
    data['image'] = image;
    data['branchId'] = branchId;
    data['role'] = scope;
    data['status'] = status;
    return data;
  }
}
