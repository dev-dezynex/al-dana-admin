import 'package:get/get.dart';

import '../../../data/data.dart';

class UsersController extends GetxController {
  var userResult = UserResult.list().obs;
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getDetails() {
    getUsers();
  }

  void getUsers() async {
    userResult.value = await UserProvider().getUserList();
    for (User user in userResult.value.userList) {
      switch (user.scope) {
        case "admin":
          adminList.add(user);
          break;
        case "manager":
          managerList.add(user);
          break;
        case "technician":
          technicianList.add(user);
          break;
        case "customer":
          customerList.add(user);
          break;
      }
    }
    update();
  }
}
