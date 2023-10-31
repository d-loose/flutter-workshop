import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:timerapp/timer_model.dart';

abstract class Callback {
  void call();
}

class MockCallback extends Mock implements Callback {}

void main() {
  test('init', () {
    final model = TimerModel();

    expect(model.isRunning, isFalse);
    expect(model.remaining, equals(Duration.zero));
  });

  test('add and remove time', () {
    final model = TimerModel();
    final mockCallback = MockCallback();
    model.addListener(mockCallback);

    model.addTime(const Duration(minutes: 5));
    verify(mockCallback).called(1);
    expect(model.remaining.inMinutes, equals(5));
    expect(model.isRunning, isFalse);

    model.addTime(const Duration(seconds: -12));
    verify(mockCallback).called(1);
    expect(model.remaining.inSeconds, equals(288));
    expect(model.isRunning, isFalse);
  });

  test('start and finish', () {
    final model = TimerModel();
    final mockCallback = MockCallback();
    model.addListener(mockCallback);
    const startTime = Duration(minutes: 10);

    fakeAsync((async) {
      model.addTime(startTime);
      model.start();
      verify(mockCallback).called(2);
      expect(model.isRunning, isTrue);

      async.elapse(TimerModel.interval);
      verify(mockCallback).called(1);
      expect(model.remaining, equals(startTime - TimerModel.interval));

      async.elapse(model.remaining);
      verify(mockCallback).called(greaterThanOrEqualTo(599));
      expect(model.remaining, equals(Duration.zero));
      expect(model.isRunning, isFalse);

      async.elapse(startTime);
      verifyNever(mockCallback);
    });
  });
}
