import 'dart:io';

// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';


class FileService {

  static String _extStorage = "";

  static Map<String, Future Function()> downloadTasks = {};

  static Future<List<String>> ensureReady() async {
    await createFolder('MathsOne');
    String media = await createFolder('MathsOne/Media');

    return <String>[
      await createFolder('MathsOne/Media/Images'),
      await createFolder('MathsOne/Media/Documents'),
      await createFolder('MathsOne/Media/Video'),
      await createFolder('MathsOne/Media/Audio'),
      await createFolder('MathsOne/Media/Statuses'),
      media,
      await createFolder('MathsOne/Media/ProfilePictures'),
      await createFolder('MathsOne/Database'),
    ];
  }

  // static requestScopedStorage( storage ) async {
  //   bool? isGranted = await Saf(storage).getDirectoryPermission(isDynamic: false);

  //   if (isGranted != null && isGranted) {
  //     // Perform some file operations
  //     return storage;
  //   } else {
  //     // failed to get the permission
  //     Get.snackbar('Permission Error', 'Please press use this folder on the next screen to allow storage writes permission!');
  //     Future.delayed(Duration(seconds: 3), () async {
  //       await requestScopedStorage( storage );
  //     });
  //   }
  // }

  static Future<String> createFolder(String cow) async {
    if( _extStorage == ""){
      if( Platform.isAndroid ){
        Directory? extStorage = await getExternalStorageDirectory();
        print("***********************${extStorage!.path}***************************");
        _extStorage = extStorage.path.split('Android')[0];
      } else {
        _extStorage = (await getApplicationDocumentsDirectory()).path;
      }
    }

    final folderName = cow;
    final path = Directory("$_extStorage$folderName");
    if ((await path.exists())) {
      return path.path;
    } else {
      var status = await Permission.storage.request();
      if (status != PermissionStatus.granted) {
        Get.snackbar('Permission Error', 'Please allow storage permission!');
        return '';
      }
      
      try {
        await path.create();
      } catch(e){
        if( Platform.isAndroid ){
          _extStorage = (await getExternalStorageDirectory())!.path;
          //var d = _extStorage.split('data');
          //_extStorage = "${d[0]}media${Platform.pathSeparator}${d[1].split(Platform.pathSeparator)[1]}${Platform.pathSeparator}";
          //await requestScopedStorage("${_extStorage}Talkmia");
          print(_extStorage);
          return await createFolder( cow );
        } else {
          rethrow;
        }
      }
      return path.path;
    }
  }

  static Future<File> moveFile(File sourceFile, String newPath) async {
    var fileName = sourceFile.path.split(Platform.pathSeparator).last;
    newPath = "$newPath${Platform.pathSeparator}$fileName";
    try {
      // prefer using rename as it is probably faster
      return await sourceFile.rename(newPath);
    } on FileSystemException {
      // if rename fails, copy the source file and then delete it
      final newFile = await sourceFile.copy(newPath);
      await sourceFile.delete();
      return newFile;
    }
  }

  // static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
  //   final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
  //   send?.send([id, status, progress]);
  // }
}