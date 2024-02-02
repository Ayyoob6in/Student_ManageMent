import 'dart:io';
import 'package:get/get.dart';
import 'package:learn/presentation/widgets/image_picker.dart';

class ImagePickerController extends GetxController {
  Rx<File?> pickedImage = Rx<File?>(null);

  Future<File?> pickImage() async {
    File? pickedImage = await HomeImagePicker().pickImageFromGallery() as File?;
    print("Picked Image: $pickedImage");
    if (pickedImage != null) {
      this.pickedImage.value = pickedImage;
      return pickedImage;
    } else {
      return null;
    }
  }
}


