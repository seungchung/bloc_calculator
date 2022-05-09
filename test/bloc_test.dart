import 'package:flutter_test/flutter_test.dart';
import 'utils.dart';

void main() {
  group('basic input tests', () {
    simplifiedTest(
      '123',
      currentValue: 123,
    );
    simplifiedTest(
      '01',
      currentValue: 1,
    );
    simplifiedTest(
      '1+2=',
      currentValue: 3,
    );
    simplifiedTest(
      '1+2+3+4=',
      currentValue: 10,
    );
    simplifiedTest(
      '1/3=',
      currentValue: 1 / 3,
    );
    simplifiedTest(
      '1/3+2=',
      currentValue: 7 / 3,
    );
  });
}
