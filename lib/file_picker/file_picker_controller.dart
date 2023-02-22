import 'dart:async';
import 'dart:io';
import 'package:arana_file_picker/file_picker/file_picker_model.dart';
import 'package:path_provider/path_provider.dart';

mixin FilePickerController {
  Future<void> getFileDir() async {
    Directory? directory = await rootDirectory();
    if (directory != null) {
      List<Directory> listDirect = await getListFolder(directory: Directory(directory.path));

      List<FilePickerModel> filess=[];
      for (int i = 0; i < listDirect.length; i++) {
        Directory directory = listDirect[i];
        FilePickerModel list = await getListFiles(directory: directory, fileTypes: ['Png', 'mp4','ogg']);
        if(list.files.isNotEmpty){
          filess.add(FilePickerModel(directory: directory, files: list.files));
        }
      }
      print('OK');
    }
  }

  Future<Directory?> rootDirectory() async {
    try {
      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
        String newPath = "";
        final List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          final String folder = paths[x];
          if (folder != "Android") {
            newPath += "/$folder";
          } else {
            break;
          }
        }
        directory = Directory(newPath);
      } else {
        directory = await getTemporaryDirectory();
      }
      return directory;
    } on Exception catch (_) {}
    return null;
  }

  Future<List<Directory>> getListFolder({required Directory directory, bool showHiddenFolder = false}) async {
    List<Directory> lists = [];
    List<FileSystemEntity> listsSystem = [];

    listsSystem = directory.listSync();
    for (int i = 0; i < listsSystem.length; i++) {
      FileSystemEntity file = listsSystem[i];
      if (Directory(file.path).existsSync()) {
        if (showHiddenFolder) {
          lists.add(Directory(listsSystem[i].path));
        } else {
          if (!file.path.split('/').last.startsWith('.')) {
            lists.add(Directory(listsSystem[i].path));
          }
        }
      }
    }
    return lists;
  }

  Future<FilePickerModel> getListFiles({required Directory directory, required final List<String> fileTypes, bool showHiddenFolder = false}) async {
    List<File> lists = [];
    List<FileSystemEntity> listsSystem = [];
    List<String> _fileTypes = fileTypes;
    for (int i = 0; i < _fileTypes.length; i++) {
      String type = _fileTypes[i].toLowerCase();
      _fileTypes[i] = type;
    }

    listsSystem = directory.listSync();
    for (int i = 0; i < listsSystem.length; i++) {
      FileSystemEntity file = listsSystem[i];
      if (!Directory(file.path).existsSync()) {
        String fileType = file.path.split('.').last.toLowerCase();
        if (_fileTypes.isEmpty || _fileTypes.contains(fileType)) {
          if (showHiddenFolder) {
            lists.add(File(listsSystem[i].path));
          } else {
            if (!file.path.split('/').last.startsWith('.')) {
              lists.add(File(listsSystem[i].path));
            }
          }
        }
      }
    }

    FilePickerModel filePickerModel = FilePickerModel(directory: directory, files: lists);
    print('ok');
    return filePickerModel;
  }
}
