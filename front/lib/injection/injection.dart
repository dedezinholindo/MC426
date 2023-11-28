import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mc426_front/authentication/authentication.dart';
import 'package:mc426_front/create_complaint/complaint.dart';
import 'package:mc426_front/profile/profile.dart';
import 'package:mc426_front/storage/storage_shared.dart';

final getIt = GetIt.instance;

initializeStorage() async {
  await GetIt.instance.get<StorageShared>().initialize();
}

setupProviders() async {
  final StorageShared storageShared = StorageShared();
  final http.Client client = http.Client();

  getIt.registerSingleton<StorageShared>(storageShared);

  //complaint
  getIt.registerLazySingleton<ComplaintRepository>(() => ComplaintApiRepository(client));
  getIt.registerLazySingleton<CreateComplaintUsecase>(() => CreateComplaintUsecase(getIt.get<ComplaintRepository>()));

  //authentication
  getIt.registerLazySingleton<AuthenticationRepository>(() => AuthenticationApiRepository(client));
  getIt.registerLazySingleton<SignInUsecase>(() => SignInUsecase(
        getIt.get<AuthenticationRepository>(),
        storageShared,
      ));
  getIt.registerLazySingleton<SignUpUsecase>(() => SignUpUsecase(
        getIt.get<AuthenticationRepository>(),
        storageShared,
      ));

  //profile
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileApiRepository(client));
  getIt.registerLazySingleton<EditProfileUsecase>(() => EditProfileUsecase(
        getIt.get<ProfileRepository>(),
        storageShared,
      ));
  getIt.registerLazySingleton<GetProfileUsecase>(() => GetProfileUsecase(
        getIt.get<ProfileRepository>(),
        storageShared,
      ));
}
