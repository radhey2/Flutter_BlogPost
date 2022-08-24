abstract class IAuthRepo {
  signIn({required String email, required String password}) {}

  signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) {}
}
