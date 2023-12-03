import 'package:mc426_front/authentication/domain/repositories/authentication_repository.dart';

class ForgotPasswordUsecase {
  final AuthenticationRepository repository;

  ForgotPasswordUsecase(this.repository);

  Future<bool> call(String email) async {
    return await repository.sendPasswordReset(email);
  }
}