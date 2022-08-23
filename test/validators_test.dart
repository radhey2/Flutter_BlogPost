import 'package:blogpost/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators', () {
    test('Invalid Email', () {
      var result = Validators.validateEmail('abcd');
      expect(result, 'Not a valid email');
    });

    test(' valid Email', () {
      var result = Validators.validateEmail('abcd@gmail.com');
      expect(result, null);
    });

    test('Empty Email', () {
      var result = Validators.validateEmail('');
      expect(result, 'Not a valid email');
    });
  });
}
