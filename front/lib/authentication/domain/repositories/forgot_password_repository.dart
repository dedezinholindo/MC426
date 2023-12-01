abstract class ForgotPasswordRepository {
  Future<bool> sendPasswordReset(String email);
}