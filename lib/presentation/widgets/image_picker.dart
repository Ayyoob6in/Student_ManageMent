

import 'dart:io';

import 'package:image_picker/image_picker.dart';

class HomeImagePicker{
  Future<File?> pickImageFromGallery() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    // ignore: unused_local_variable
    return  File(pickedFile.path);
  } else {
    return null; 
  }
}

}