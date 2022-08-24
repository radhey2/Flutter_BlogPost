import 'package:blogpost/Auth/datasource/auth_repo.dart';
import 'package:blogpost/Auth/datasource/modal.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/mock_Iauth_repo.dart';
import 'mocks/mock_auth_repo.dart';

void main() {
  group('Auth Repo Testing', () {
    final IAuthRepo repo = MockAuthRepo();
    test('empty String', () async {
      var result = AuthRepository();
      var res = result.signIn(email: '', password: '');
      expect(await res, false);
    });

    test('Invalid Email', () async {
      var result = AuthRepository();
      var res = result.signIn(email: 'kafsjhc', password: '');
      expect(await res, false);
    });

    test('singleton check', () {
      expect(repo, MockAuthRepo());
    });

    test('login test', () async {
      expect(await repo.signIn(email: '', password: ''), null);

      final actual =
          await repo.signIn(email: 'abcd@gmail.com', password: 'qwerty12');

      final expected = User(
        email: "abcd@gmail.com",
        firstName: "radhey",
        lastName: "bagwan",
      );
      expect(actual, expected);
    });
    test('sign up test', () async {
      expect(
          await repo.signUp(
            email: '',
            password: '',
            firstName: '',
            lastName: '',
          ),
          true);
    });
  });
}
