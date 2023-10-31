import 'package:flutter/material.dart';

import 'timer_page.dart';

class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimerPage.create(context),
      debugShowCheckedModeBanner: false,
    );
  }
}
