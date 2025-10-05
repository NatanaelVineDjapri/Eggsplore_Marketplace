class ImageHelper {
  static const String _androidEmulatorUrl = "http://10.0.2.2:8000";

  static String getImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return '';

    // kalau sudah full URL jangan diubah
    if (imagePath.startsWith('http')) {
      return imagePath;
    }

    final cleanedPath = imagePath.startsWith('/')
        ? imagePath.substring(1)
        : imagePath;

    return "$_androidEmulatorUrl/$cleanedPath";
  }
}