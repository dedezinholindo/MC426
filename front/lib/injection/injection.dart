import 'package:get_it/get_it.dart';
import 'package:mc426_front/create_complaint/data/repositories/complaint_api_repository.dart';
import 'package:mc426_front/create_complaint/domain/repositories/complaint_repository.dart';
import 'package:mc426_front/create_complaint/domain/usecases/create_complaint_usecase.dart';
import 'package:http/http.dart' as http;
import 'package:mc426_front/authentication/authentication.dart';

final getIt = GetIt.instance;

setupProviders() {
  final http.Client client = http.Client();
  getIt.registerLazySingleton<ComplaintRepository>(() => ComplaintApiRepository(client));
  getIt.registerLazySingleton<CreateComplaintUsecase>(() => CreateComplaintUsecase(getIt.get<ComplaintRepository>()));
  getIt.registerLazySingleton<AuthenticationRepository>(() => AuthenticationApiRepository(client));
  getIt.registerLazySingleton<SignInUsecase>(() => SignInUsecase(
        getIt.get<AuthenticationRepository>(),
      ));
  getIt.registerLazySingleton<SignUpUsecase>(() => SignUpUsecase(
        getIt.get<AuthenticationRepository>(),
      ));
}
