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
        maxHeight: Constants.kMaxHeight,
        maxWidth: Constants.kMaxWidth,
        imageQuality: Constants.kImageQuality,
      );
      // if (image == null) return;
      // final imageResult = File(image.path);
      // // pathImage = image.path;
    } catch (e) {
      AllertDropdown.error("Failed to pick image $e");
      throw ("Picker Failed");
    }
  }
}