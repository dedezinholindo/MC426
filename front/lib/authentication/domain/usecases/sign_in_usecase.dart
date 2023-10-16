import 'package:mc426_front/authentication/authentication.dart';

class SignInUsecase {
  final AuthenticationRepository repository;

  SignInUsecase(this.repository);

  Future<AuthenticationResult> call(SignInEntity signInEntity) async {
    return await repository.signIn(signInEntity);
  }
}
