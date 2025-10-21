import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/rendering.dart';
import 'package:hader_pharm_mobile/config/services/deeplinks/actions/handle_orders.dart';
import 'package:hader_pharm_mobile/config/services/deeplinks/deeplinks_service_port.dart';

class DeeplinksService implements DeeplinksServicePort {
  StreamSubscription? _linksStream;

  @override
  Future<void> init() async {
    _linksStream = AppLinks().uriLinkStream.listen(handleDeepLinkUri);

    // Handle initial link when app is launched from deep link
    final initialUri = await AppLinks().getInitialLink();
    if (initialUri != null) {
      handleDeepLinkUri(initialUri);
    }
  }

  @override
  void handleDeepLinkUri(Uri? uri) {
    final segments = uri?.pathSegments;
    final String? rootSegment = segments?.firstOrNull;

    if (rootSegment != null) {
      switch (rootSegment) {
        case "order":
          handleOrderDeepLink(uri!);
        default:
          debugPrint("No handler registered");
      }
    }
  }

  @override
  void handleDeepLink(String link) {
    final uri = Uri.parse(link);
    handleDeepLinkUri(uri);
  }

  @override
  void cancelStreamSubscribtion() {
    _linksStream?.cancel();
  }
}
