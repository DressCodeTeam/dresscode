import 'package:dresscode/src/shared/extensions/time_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TimeExtension Tests', () {
    group('seconds', () {
      test('Positive integer returns correct Duration', () {
        expect(5.seconds, const Duration(seconds: 5));
      });

      test('Zero returns Duration.zero', () {
        expect(0.seconds, Duration.zero);
      });

      test('Negative integer returns negative Duration', () {
        expect((-3).seconds, const Duration(seconds: -3));
      });
    });

    group('milliseconds', () {
      test('Positive integer returns correct Duration', () {
        expect(250.milliseconds, const Duration(milliseconds: 250));
      });

      test('Zero returns Duration.zero', () {
        expect(0.milliseconds, Duration.zero);
      });

      test('Negative integer returns negative Duration', () {
        expect((-100).milliseconds, const Duration(milliseconds: -100));
      });
    });

    test('Verify type safety', () {
      expect(10.seconds, isA<Duration>());
      expect(500.milliseconds, isA<Duration>());
    });
  });
}
