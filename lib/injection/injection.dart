import 'package:get_it/get_it.dart';
import 'package:mc426_front/hello_world/hello_world.dart';

final getIt = GetIt.instance;

setupProviders() {
  getIt.registerLazySingleton<HelloWorldRepository>(() => HelloWorldApiRepository());
}
