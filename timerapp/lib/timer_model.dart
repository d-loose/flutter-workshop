import 'dart:async';

import 'package:flutter/material.dart';

class TimerModel with ChangeNotifier {
  static const interval = Duration(seconds: 1);

  Duration remaining = Duration.zero;

  Timer? _timer;
  bool get isRunning => _timer?.isActive ?? false;

  void addTime(Duration duration) {
    remaining += duration;
    notifyListeners();
  }

  void cancel() {
    _timer?.cancel();
    notifyListeners();
  }

  void start() {
    if (remaining <= Duration.zero) {
      return;
    }
    _timer = Timer.periodic(interval, _update);
    notifyListeners();
  }

  void _update(Timer t) {
    remaining -= interval;
    if (remaining <= Duration.zero) {
      _timer?.cancel();
    }
    notifyListeners();
  }
}
