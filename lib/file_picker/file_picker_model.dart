import 'dart:io';

class FilePickerModel {
  FilePickerModel({
    required this.directory,
    required this.files,
  });

  Directory directory;
  List<File> files;
}
