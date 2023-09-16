import 'package:get_it/get_it.dart';
import 'package:mc426_front/authentication/authentication.dart';

final getIt = GetIt.instance;

setupProviders() {
  getIt.registerLazySingleton<AuthenticationRepository>(() => AuthenticationApiRepository());
  getIt.registerLazySingleton<SignInUsecase>(() => SignInUsecase(
        getIt.get<AuthenticationRepository>(),
      ));
  getIt.registerLazySingleton<SignUpUsecase>(() => SignUpUsecase(
        getIt.get<AuthenticationRepository>(),
      ));
}
