import 'package:hader_pharm_mobile/repositories/locale/privacy_policy/actions/load.dart';
import 'package:hader_pharm_mobile/repositories/locale/privacy_policy/privacy_policy_repository.dart';

class PrivacyPolicyRepositoryImpl implements IPrivacyPolicyRepository {
  @override
  Future<String> getPrivacyPolicy([String langCode = 'fr']) async {
    return loadPrivacyPolicy(langCode);
  }
}
