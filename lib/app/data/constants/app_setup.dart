

import 'file_service.dart';
import 'permissions.dart';

class AppSetup {
  static setup() async {
    await Permissions.setup();
    await FileService.ensureReady();
  }
}
