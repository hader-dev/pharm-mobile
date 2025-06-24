import 'package:hader_pharm_mobile/utils/app_permission_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceGalleryHelper {
  // Method to pick an image from the gallery
  static Future<XFile?> pickImageFromGallery({ImageSource source = ImageSource.gallery}) async {
    XFile? image;
    PermissionStatus isPermissionGranted = await AppPermissionsHelper.checkPhotosPermission();
    if (isPermissionGranted == PermissionStatus.granted) {
      final ImagePicker picker = ImagePicker();
      image = await picker.pickImage(source: source);
    }
    return image;
  }
}
