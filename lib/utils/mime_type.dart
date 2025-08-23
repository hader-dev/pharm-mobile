import 'package:flutter/material.dart';

String getMimeTypeFromExtension(String fileExtension) {
  switch (fileExtension) {
    case 'png':
      return 'image/png';
    case 'jpg':
    case 'jpeg':
      return 'image/jpeg';
    case 'gif':
      return 'image/gif';
    case 'tif':
    case 'tiff':
      return 'image/tiff';
    case 'svg':
      return 'image/svg+xml';
    case 'bmp':
      return 'image/bmp';
    case 'webp':
      return 'image/webp';
    default:
      // Default to jpeg for unknown extensions
      debugPrint(
          "Unknown file extension: $fileExtension, defaulting to image/jpeg");
      return 'image/jpeg';
  }
}
