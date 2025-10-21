abstract class DeeplinksServicePort {
  Future<void> init();
  void handleDeepLink(String link);
  void handleDeepLinkUri(Uri uri);
  void cancelStreamSubscribtion();
}
