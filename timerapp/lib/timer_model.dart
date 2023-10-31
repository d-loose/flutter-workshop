import 'package:flutter/material.dart';

class TimerModel with ChangeNotifier {
  final isRunning = false;
  Duration remaining = Duration.zero;

  void addTime(Duration duration) {
    remaining += duration;
    notifyListeners();
  }
}
