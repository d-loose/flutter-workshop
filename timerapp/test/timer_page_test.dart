import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:timerapp/timer_model.dart';
import 'package:timerapp/timer_page.dart';
import 'package:yaru/yaru.dart';

class MockTimerModel extends Mock implements TimerModel {}

MockTimerModel createMockTimerModel({
  Duration remaining = Duration.zero,
  bool isRunning = false,
}) {
  final model = MockTimerModel();
  when(() => model.remaining).thenReturn(remaining);
  when(() => model.isRunning).thenReturn(false);
  return model;
}

void main() {
  testWidgets('remaining time', (tester) async {
    final mockTimerModel = createMockTimerModel(
      remaining: const Duration(hours: 12, minutes: 16, seconds: 43),
    );
    await tester.pumpYaruWidget(
      ChangeNotifierProvider<TimerModel>.value(
        value: mockTimerModel,
        child: const TimerPage(),
      ),
    );

    for (final testCase in [
      (widgetKey: TimerPage.hoursColumnKey, value: '12'),
      (widgetKey: TimerPage.minutesColumnKey, value: '16'),
      (widgetKey: TimerPage.secondsColumnKey, value: '43'),
    ]) {
      expect(
        find.descendant(
          of: find.byKey(testCase.widgetKey),
          matching: find.text(testCase.value),
        ),
        findsOneWidget,
      );
    }
  });

  testWidgets('modify time', (tester) async {
    final mockTimerModel = createMockTimerModel();
    await tester.pumpYaruWidget(
      ChangeNotifierProvider<TimerModel>.value(
        value: mockTimerModel,
        child: const TimerPage(),
      ),
    );

    throw UnimplementedError();
  });
}

extension on WidgetTester {
  Future<void> pumpYaruWidget(Widget widget) {
    return pumpWidget(YaruTheme(
      builder: (context, yaru, child) => MaterialApp(
        theme: yaru.theme,
        darkTheme: yaru.darkTheme,
        home: widget,
      ),
    ));
  }
}
