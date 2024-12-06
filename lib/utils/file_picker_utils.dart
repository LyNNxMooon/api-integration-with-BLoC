import 'dart:io';

import 'package:image_picker/image_picker.dart';

class FilePickerUtil {
  Future<File?> getImage(bool isCamera) async {
    final picker = ImagePicker();

    if (isCamera) {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        return null;
      }
    } else {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        return null;
      }
    }
  }
}
