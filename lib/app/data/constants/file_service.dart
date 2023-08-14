import 'dart:io';

// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

import 'keys.dart';

class FileService {
  static Map<String, Future Function()> downloadTasks = {};

  static Future<List<String>> ensureReady() async {
    await _createFolder(path_main);

    return <String>[
      await _createFolder(path_invoice),
    ];
  }

  static Future<String> _createFolder(String filePath) async {
    Directory? baseDir;
    String path = await getBaseFilePath();
    if (path.isNotEmpty) {
      baseDir = Directory(path);
    }
    try {
      await baseDir!.create(recursive: true);
    } catch (e) {
      if (kDebugMode) {
        print('in catch $e');
      }
    }
    return baseDir?.path ?? '';
  }

  static Future<String> getBaseFilePath() async {
    Directory? baseDir;
    if (Platform.isAndroid) {
      if (await _requestPermission(Permission.storage)) {
        baseDir = await getExternalStorageDirectory();
        String newPath = '';
        List<String> folders = baseDir!.path.split('/');
        for (int i = 1; i < folders.length; i++) {
          String folder = folders[i];
          if (folder != 'Android') {
            newPath += "/$folder";
          } else {
            break;
          }
        }
        return newPath;
      }
    } else {
      if (await _requestPermission(Permission.storage)) {
        // baseDir = await getTemporaryDirectory();
        baseDir = await getApplicationDocumentsDirectory();
        return baseDir.path;
      }
    }
    return '';
  }

  static _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
