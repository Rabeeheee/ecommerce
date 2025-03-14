import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

Future<File?> pickImageForMobile() async {
  try {
    final xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (xFile != null) {
      return File(xFile.path);
    }
    return null;
  } catch (e) {
    // print('Error picking image: $e');
    return null;
  }
}

Future<Uint8List?> pickImageForWeb() async {
  try {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      'png',
      'jpeg',
      'jpg',
    ]);
    if (result != null) {
      final file = result.files.single.bytes;
      return file;
    }
    return null;
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<List<Uint8List>?> pickMultipleImagesForWeb() async {
  final result = await FilePicker.platform
      .pickFiles(allowMultiple: true, type: FileType.custom, allowedExtensions: [
    'png',
    'jpeg',
    'jpg',
  ]);
  if (result != null) {
    final listFile = result.files.map((e) => e.bytes!).toList();
    return listFile;
  }
  return null;
}

Future<List<File>?> pickMultipleImagesForMobile() async {
  try {
    final List<XFile> listXFile = await ImagePicker().pickMultiImage();
    final List<File> listFile = listXFile.map((e) => File(e.path)).toList();
    return listFile;
  } catch (e) {
    // print('Error picking multiple images: $e');
    return null;
  }
}
