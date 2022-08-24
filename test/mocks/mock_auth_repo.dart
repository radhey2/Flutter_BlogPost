import 'package:blogpost/Auth/datasource/modal.dart';

import 'mock_Iauth_repo.dart';

class MockAuthRepo implements IAuthRepo {
  static MockAuthRepo? _instance;
  MockAuthRepo._(); // Private Constructor
  factory MockAuthRepo() {
    _instance ??= MockAuthRepo._(); // ??= is called Elvis Operator
    return _instance!;
  }

  User? _user;
  User? get currentUser => _user;

  @override
  Future signIn({required String email, required String password}) async {
    if (email == "abcd@gmail.com" && password == 'qwerty12') {
      _user = User(
          email: 'abcd@gmail.com', firstName: 'radhey', lastName: 'bagwan');
      return _user;
    }
    return null;
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    return true;
  }
}
