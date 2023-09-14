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
    //file yang diambilnya hanyalah tipe gambar, dan izin utk ambil
    //lebih dari 1
    var files = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);

    //kalau filenya beneran ada
    if (files != null && files.files.isNotEmpty) {
      for (var i = 0; i < files.files.length; i++) {
        //untuk tampung data semua gambarnya
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  return images; //tampilkan / lempar gambarnya
}
