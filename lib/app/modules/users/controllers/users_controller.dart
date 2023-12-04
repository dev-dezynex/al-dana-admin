import 'dart:developer';

import 'package:get/get.dart';

import '../../../data/data.dart';

class UsersController extends GetxController {
  var isLoading = false.obs;
  var userResult = UserResult.list().obs;
  var customerResult = UserResult.list().obs;
  var managerList = <User>[].obs;
  var technicianList = <User>[].obs;
  var customerList = <User>[].obs;
  var adminList = <User>[].obs;
  var tabIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getDetails();
  }

  void getDetails() async {
    isLoading(true);
    await getUsers();
    await getCustomers();
    isLoading(false);
  }

  clearLists() {
    adminList.clear();
    managerList.clear();
    technicianList.clear();
    customerList.clear();
  }

  getCustomers() async {
    customerList.clear();
    customerResult.value = await UserProvider().getActiveCustomers();
    for (User customer in customerResult.value.userList) {
      customerList.add(customer);
    }
    log('Customer called');
  }

  getUsers() async {
    clearLists();
    userResult.value = await UserProvider().getActiveUsers();
    // print('userList ${jsonEncode(userResult.value.userList)}');
    for (User user in userResult.value.userList) {
      switch (user.scope) {
        case "admin":
          adminList.add(user);
          break;
        case "serviceManager":
          managerList.add(user);
          break;
        case "technician":
          technicianList.add(user);
          break;
      }
    }
    update();
  }
}
