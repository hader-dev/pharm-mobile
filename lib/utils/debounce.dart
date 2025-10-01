import 'dart:async';
import 'dart:ui';

class DebouncerManager {
  final Map<String, Timer> _timers = {};

  void debounce({
    required String tag,
    required VoidCallback action,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    _timers[tag]?.cancel();

    _timers[tag] = Timer(duration, () {
      action();
      _timers.remove(tag);
    });
  }

  void cancel(String tag) {
    _timers[tag]?.cancel();
    _timers.remove(tag);
  }

  void dispose() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
  }
}
