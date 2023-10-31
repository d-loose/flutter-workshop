import 'package:flutter/material.dart';
import 'package:yaru_widgets/widgets.dart';

class TimerPage extends StatelessWidget {
  @visibleForTesting
  const TimerPage({super.key});

  static Widget create(BuildContext context) {
    return const TimerPage();
  }

  static const hoursColumnKey = Key('hours column');
  static const minutesColumnKey = Key('minutes column');
  static const secondsColumnKey = Key('seconds column');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YaruWindowTitleBar(title: Text('Timer App')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TimerColumn(
                  key: hoursColumnKey,
                  value: 12,
                ),
                Text(':'),
                _TimerColumn(
                  key: minutesColumnKey,
                  value: 34,
                ),
                Text(':'),
                _TimerColumn(
                  key: secondsColumnKey,
                  value: 56,
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
        Text(value.toString()),
      ],
    );
  }
}
