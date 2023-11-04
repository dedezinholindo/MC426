import 'package:mc426_front/authentication/authentication.dart';

class SignUpUsecase {
  final AuthenticationRepository repository;

  SignUpUsecase(this.repository);

  Future<AuthenticationResult> call(SignUpEntity signUpEntity) async {
    return await repository.signup(signUpEntity);
  }
}
