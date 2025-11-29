import 'package:image_picker/image_picker.dart';

class DeviceGalleryHelper {
  // Method to pick an image from the gallery
  static Future<XFile?> pickImageFromGallery({ImageSource source = ImageSource.gallery}) async {
    XFile? image;

    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: source);

    return image;
  }
}
