import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnakBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

// mention the return type is a very good practise
Future<List<File>> pickImages() async {
  List<File> images = [];
  var files = await FilePicker.platform.pickFiles(
    type: FileType.image,
    //allow multiple images to be uploaded
    allowMultiple: true,
  );
  if (files != null && files.files.isNotEmpty) {
    for (int i = 0; i < files.files.length; i++) {
      images.add(File(files.files[i].path!));
    }
  }
  try {} catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
