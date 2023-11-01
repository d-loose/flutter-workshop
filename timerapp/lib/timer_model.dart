import 'dart:async';

import 'package:desktop_notifications/desktop_notifications.dart';
import 'package:flutter/material.dart' hide Notification;

class TimerModel with ChangeNotifier {
  TimerModel(this.notificationsClient);

  final NotificationsClient notificationsClient;
  static const interval = Duration(seconds: 1);

  Duration remaining = Duration.zero;

  Timer? _timer;
  bool get isRunning => _timer?.isActive ?? false;

  Notification? _notification;
  bool get hasNotification => _notification != null;

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
      _notify();
    }
    notifyListeners();
  }

  Future<void> _notify() async {
    _notification = await notificationsClient.notify('Timer is done!');
    notifyListeners();

    await _notification?.closeReason;
    _notification = null;
    notifyListeners();
  }
}
