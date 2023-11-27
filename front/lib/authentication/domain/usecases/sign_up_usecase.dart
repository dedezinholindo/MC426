import 'package:mc426_front/authentication/authentication.dart';
import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/storage/storage.dart';

class SignUpUsecase {
  final AuthenticationRepository repository;
  final StorageInterface storage;

  SignUpUsecase(this.repository, this.storage);

  Future<AuthenticationResult> call(SignUpEntity signUpEntity) async {
    final result = await repository.signup(signUpEntity);
    await storage.setString(userId, result.id != null ? result.id! : "logged_out");
    return result;
  }
}
