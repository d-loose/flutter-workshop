import 'package:desktop_notifications/desktop_notifications.dart';
import 'package:flutter/widgets.dart';
import 'package:ubuntu_service/ubuntu_service.dart';

import 'timer_app.dart';

void main() {
  registerService(
    NotificationsClient.new,
    dispose: (service) => service.close(),
  );

  return runApp(const TimerApp());
}
