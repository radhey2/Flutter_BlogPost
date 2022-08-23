import 'package:blogpost/Auth/datasource/auth_repo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('', () async {
    var result = AuthRepository();
    var res =
        result.signIn(email: 'radheshyam.bagwan@spicemoney.com', password: '');
    expect(await res, false);
  });
}
