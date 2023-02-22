import 'dart:io';

import 'package:arana_file_picker/file_picker/file_picker_controller.dart';
import 'package:flutter/material.dart';

class FilePickerPage extends StatefulWidget {
  const FilePickerPage({Key? key}) : super(key: key);

  @override
  State<FilePickerPage> createState() => _FilePickerPageState();
}

class _FilePickerPageState extends State<FilePickerPage> with FilePickerController{

  @override
  void initState() {
    // TODO: implement initState

    getFileDir();


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
