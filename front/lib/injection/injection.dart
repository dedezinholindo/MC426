import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mc426_front/authentication/authentication.dart';
import 'package:mc426_front/complaint/complaint.dart';
import 'package:mc426_front/storage/storage_shared.dart';

final getIt = GetIt.instance;

setupProviders() async {
  final StorageShared storageShared = StorageShared();
  final http.Client client = http.Client();

  await storageShared.initialize();
  getIt.registerLazySingleton<StorageShared>(() => storageShared);

  getIt.registerLazySingleton<ComplaintRepository>(() => ComplaintApiRepository(client));
  getIt.registerLazySingleton<CreateComplaintUsecase>(() => CreateComplaintUsecase(getIt.get<ComplaintRepository>()));
  getIt.registerLazySingleton<VoteRepository>(() => VoteApiRepository(client));
  getIt.registerLazySingleton<VoteUseCase>(() => VoteUseCase(getIt.get<VoteRepository>()));
  getIt.registerLazySingleton<AuthenticationRepository>(() => AuthenticationApiRepository(client));
  getIt.registerLazySingleton<SignInUsecase>(() => SignInUsecase(
        getIt.get<AuthenticationRepository>(),
        storageShared,
      ));
  getIt.registerLazySingleton<SignUpUsecase>(() => SignUpUsecase(
        getIt.get<AuthenticationRepository>(),
        storageShared,
      ));
}