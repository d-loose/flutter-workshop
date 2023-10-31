import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timerapp/timer_model.dart';
import 'package:yaru_widgets/widgets.dart';

class TimerPage extends StatelessWidget {
  @visibleForTesting
  const TimerPage({super.key});

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimerModel(),
      builder: (_, __) => const TimerPage(),
    );
  }

  static const hoursColumnKey = Key('hours column');
  static const minutesColumnKey = Key('minutes column');
  static const secondsColumnKey = Key('seconds column');

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TimerModel>();

    return Scaffold(
      appBar: const YaruWindowTitleBar(title: Text('Timer App')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TimerColumn(
                  key: hoursColumnKey,
                  value: model.remaining.inHours,
                ),
                const Text(':'),
                _TimerColumn(
                  key: minutesColumnKey,
                  value: model.remaining.inMinutes % 60,
                ),
                const Text(':'),
                _TimerColumn(
                  key: secondsColumnKey,
                  value: model.remaining.inSeconds % 60,
                ),
              ],
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimerColumn extends StatelessWidget {
  const _TimerColumn({super.key, required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(NumberFormat("00").format(value)),
      ],
    );
  }
}
