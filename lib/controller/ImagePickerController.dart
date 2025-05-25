import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Imagepickercontroller extends GetxController {
  Future<File?> getImage(ImageSource mysource, BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(source: mysource, imageQuality: 50,);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nothing is selected')),
      );
    }
    return null;
  }
}
