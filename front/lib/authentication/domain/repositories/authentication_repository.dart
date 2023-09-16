import 'package:mc426_front/authentication/authentication.dart';

abstract class AuthenticationRepository {
  Future<AuthenticationResult> signIn(SignInEntity signInEntity);
  Future<AuthenticationResult> signup(SignUpEntity signUpEntity);
}
