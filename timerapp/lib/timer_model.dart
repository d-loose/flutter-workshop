import 'package:flutter/material.dart';

class TimerModel with ChangeNotifier {
  final isRunning = false;
  final remaining = Duration.zero;

  void addTime(Duration duration) {
    throw UnimplementedError();
  }
}
