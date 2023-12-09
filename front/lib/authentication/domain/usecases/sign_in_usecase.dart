import 'package:mc426_front/authentication/authentication.dart';
import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/storage/storage.dart';

class SignInUsecase {
  final AuthenticationRepository repository;
  final StorageInterface storage;

  const SignInUsecase(this.repository, this.storage);

  Future<AuthenticationResult> call(SignInEntity signInEntity) async {
    final result = await repository.signIn(signInEntity);
    await storage.setString(userIdKey, result.id != null ? result.id! : "logged_out");
    return result;
  }
}
