import 'package:hader_pharm_mobile/models/mobile_app_version.dart';
import 'package:hader_pharm_mobile/repositories/remote/configs/params/mobile_app_version.dart';

abstract class IConfigRepository {
  Future<MobileAppVersion> getAvaillableAppUpdate(
      ParamsMobileAppVersion params);
}
