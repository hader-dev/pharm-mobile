// scroll_listener_helper.dart

import 'package:flutter/widgets.dart';

class ScrollListenerHelper {
  static void addEndScrollListener({
    required ScrollController controller,
    required VoidCallback onEndReached,
    double threshold = 200,
  }) {
    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - threshold) {
        onEndReached();
      }
    });
  }
}
