import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/constants/constants.dart';
import '../allert_dropdown/allert_dopdown.dart';


class PickImage {
  static Future<XFile?> imagePicker(BuildContext context) async {
    try {
      return await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: Constants.MAX_HEIGHT,
        maxWidth: Constants.MAX_WIDTH,
        imageQuality: Constants.IMAGE_QUALITY,
      );
      // if (image == null) return;
      // final imageResult = File(image.path);
      // // pathImage = image.path;
    } on PlatformException catch (e) {
      AllertDropdown.error("Failed to pick image $e");
      throw ("Picker Failed");
    }
  }
}