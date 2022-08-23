// Bloc => Business Logic Component
// Bloc -> Statemanagement (library), Bloc -> Design pattern

import 'dart:async';

import 'package:blogpost/Auth/datasource/validators.dart';

import 'package:rxdart/rxdart.dart';

import 'Auth/datasource/auth_repo.dart';
import 'observable.dart';
import 'Auth/datasource/validators.dart';

class SignInBloc with Validators {
  SignInBloc() {
    email = Observable(validator: validateEmail);
    password = Observable(validator: validatePassword);
    passwordObscure = Observable.seeded(true);
  }

  late final Observable<String?> email;
  late final Observable<String?> password;
  late final Observable<bool> passwordObscure;

  Stream<bool> get validInputObs$ =>
      Rx.combineLatest2(email.obs$, password.obs$, (a, b) => true);

  Future<bool> signIn() async {
    final user = await AuthRepository()
        .signIn(email: email.value!, password: password.value!);
    return user != null;
  }

  void dispose() {
    email.dispose();
    password.dispose();
    passwordObscure.dispose();
  }
}
