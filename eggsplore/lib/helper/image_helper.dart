import 'dart:io' show Platform;

class ImageHelper {
  static const String _androidEmulatorUrl = "http://10.0.2.2:8000";

  static String getImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return '';
    }
    return "$_androidEmulatorUrl$imagePath";
  }
}