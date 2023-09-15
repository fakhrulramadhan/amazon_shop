import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      style: const TextStyle(
        fontSize: 18.0,
      ),
    ),
  ));
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}

Future<List<File>> pickPhotos() async {
  List<File> photos = [];
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(allowMultiple: true);

  if (result != null) {
    List<File> files = result.paths.map((path) => File(path!)).toList();

    photos = files;
  } else {
    // User canceled the picker
  }

  return photos;
}
