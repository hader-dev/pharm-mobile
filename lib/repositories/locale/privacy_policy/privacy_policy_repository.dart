abstract class IPrivacyPolicyRepository {
  Future<String> getPrivacyPolicy([String langCode = 'fr']);
}
