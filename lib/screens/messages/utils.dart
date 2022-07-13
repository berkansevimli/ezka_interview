import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Utils {
  Future<File?> pickMedia({
    required bool isGallery,
    Future<File?> Function(File file)? cropImage,
  }) async {
    final source = isGallery ? ImageSource.gallery : ImageSource.camera;
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 50);

    if (pickedFile == null) return null;

    if (cropImage == null) {
      return File(pickedFile.path);
    } else {
      final file = File(pickedFile.path);
      return cropImage(file);
    }
  }

  static String toDate(DateTime dateTime) {
    final date = DateFormat.yMMMd().format(dateTime);
    return '$date';
  }

  static String toTime(DateTime dateTime) {
    final date =DateFormat.Hm().format(dateTime);
    return '$date';
  }

  
}
