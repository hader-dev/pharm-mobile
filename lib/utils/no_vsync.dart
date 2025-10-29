import 'package:flutter/scheduler.dart';

class NoVsync implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
