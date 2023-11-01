import 'package:desktop_notifications/desktop_notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timerapp/timer_model.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/widgets.dart';

class TimerPage extends StatelessWidget {
  @visibleForTesting
  const TimerPage({super.key});

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimerModel(getService<NotificationsClient>()),
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
                  interval: const Duration(hours: 1),
                ),
                const Text(':'),
                _TimerColumn(
                  key: minutesColumnKey,
                  value: model.remaining.inMinutes % 60,
                  interval: const Duration(minutes: 1),
                ),
                const Text(':'),
                _TimerColumn(
                  key: secondsColumnKey,
                  value: model.remaining.inSeconds % 60,
                  interval: const Duration(seconds: 1),
                ),
              ],
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: model.isRunning ? model.cancel : model.start,
              child: Text(model.isRunning ? 'Cancel' : 'Start'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimerColumn extends StatelessWidget {
  const _TimerColumn({super.key, required this.value, required this.interval});

  final int value;
  final Duration interval;

  @override
  Widget build(BuildContext context) {
    final model = context.read<TimerModel>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => model.addTime(interval),
          icon: const Icon(YaruIcons.plus),
        ),
        Text(NumberFormat("00").format(value)),
        IconButton(
          onPressed: () => model.addTime(-interval),
          icon: const Icon(YaruIcons.minus),
        ),
      ],
    );
  }
}
