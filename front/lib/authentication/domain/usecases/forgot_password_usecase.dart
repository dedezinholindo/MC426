import 'package:mc426_front/authentication/domain/repositories/forgot_password_repository.dart';

class ForgotPasswordUsecase {
  final ForgotPasswordRepository repository;

  ForgotPasswordUsecase(this.repository);

  Future<bool> call(String email) async {
    return await repository.sendPasswordReset(email);
  }
}