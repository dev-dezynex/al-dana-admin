import 'package:al_dana_admin/app/data/data.dart';
import 'package:get/get.dart';

class UserProvider extends GetConnect {
  // Future<UserResult> getUserList() async {
  //   final file = await rootBundle.loadString('assets/json/user_list.json');
  //   final data = await jsonDecode(file);
  //   UserResult result = UserResult.listFromJson(data);
  //   return result;
  // }

//check login
  Future<UserResult> signIn(
      {required String username, required String password}) async {
    final UserResult result;
    var body = {"username": username, "password": password};
    final response = await post(apiSignin, body);

    print('body $body');
    print('path $apiSignin');
    print('response ${response.body}');
    print('response code ${response.statusCode}');
    if (response.statusCode == 200) {
      result = UserResult.fromJson(response.body);
      var authValue = response.body['data']['token'];

      await storage.write(auth, authValue);
    } else {
      result = UserResult.fromJson(response.body);
    }

    return result;
  }

//insert user
  Future<UserResult> signUp({required User user}) async {
    final UserResult result;
    final Response<dynamic> response;
    response = await post(apiSignup, user.toJsonBody(),
        headers: Auth().requestHeaders);
    print('path $apiSignup');
    print('body ${user.toJsonBody()}');
    print('response ${response.body}');

    result = UserResult.fromJson(response.body);

    return result;
  }

  Future<UserResult> getActiveUsers({String? role}) async {
    Map<String, dynamic> qParams = {};
    if (role != null) {
      qParams['filter[role]'] = role;
    }
    final response =
        await get(apiListActiveUser, headers: Auth().requestHeaders);
    print('auth ${Auth().requestHeaders}');
    print('path $apiListActiveUser');
    print('response ${response.body}');

    return UserResult.listFromJson(response.body);
  }

  Future<UserResult> getActiveCustomers() async {
    final response = await get(
      apiListActiveCustomers,
      headers: Auth().requestHeaders,
    );
    print('auth ${Auth().requestHeaders}');
    print('path $apiListActiveUser');
    print('response ${response.body}');

    return UserResult.listFromJson(response.body);
  }

  Future<UserResult> getInactiveUsers() async {
    UserResult result;
    final response =
        await get(apiListInactiveUser, headers: Auth().requestHeaders);
    print('auth ${Auth().requestHeaders}');
    print('path $apiListInactiveUser');
    print('response ${response.body}');
    result = UserResult.listFromJson(response.body);
    return result;
  }

  Future<UserResult> inactivateUser({required User user}) async {
    UserResult result;
    final response = await delete(
      '$apiInactivateUser/${user.id}',
      headers: Auth().requestHeaders,
    );

    print('path $apiInactivateUser/${user.id}');
    print('response ${response.body}');

    result = UserResult.fromJson(response.body);

    return result;
  }

  Future<UserResult> activateUser({required User user}) async {
    UserResult result;
    final response = await put(
      '$apiActivateUser/${user.id}',
      {},
      headers: Auth().requestHeaders,
    );

    print('path $apiActivateUser/${user.id}');
    print('response ${response.body}');

    result = UserResult.fromJson(response.body);

    return result;
  }

  Future<UserResult> getProfile() async {
    final response = await get(apiReadUser, headers: Auth().requestHeaders);
    print('header ${Auth().requestHeaders}');
    print('path $apiReadUser');
    print('response ${response.body}');
    print('response code ${response.statusCode}');

    return UserResult.fromJson(response.body);
  }

  Future<UserResult> getUser({required User user}) async {
    final response = await get(apiReadUser,
        headers: Auth().requestHeaders, query: {'filter[id]': user.id});
    print('path $apiReadUser');
    print('response ${response.body}');
    print('response code ${response.statusCode}');

    return UserResult.fromJson(response.body);
  }

  Future<UserResult> updateUser({required User user}) async {
    final response = await put('$apiUpdateUser/${user.id}', user.toJsonBody(),
        headers: Auth().requestHeaders);
    return UserResult.fromJson(response.body);
  }
}
