import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import 'timer_page.dart';

class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return YaruTheme(
      builder: (context, yaru, child) => MaterialApp(
        theme: yaru.theme,
        darkTheme: yaru.darkTheme,
        home: TimerPage.create(context),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
