import 'package:test/test.dart';

class Calculator {
  int add(int a, int b) {
    return a + b;
  }

  int subtract(int a, int b) {
    return a - b;
  }
}
void main() {
  group('Calculator', () {

    setUp(() {
    });

    test('add method', () {
      expect(0, equals(0));
    });

    test('subtract method', () {
      expect(1, equals(1));
    });
  });
}
