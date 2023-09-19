import 'package:get_it/get_it.dart';
import 'package:mc426_front/Create_Complaint/data/repositories/complaint_api_repository.dart';
import 'package:mc426_front/Create_Complaint/domain/repositories/complaint_repository.dart';
import 'package:mc426_front/Create_Complaint/domain/usecases/create_complaint_usecase.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

setupProviders() {
  final http.Client client = http.Client();
  getIt.registerLazySingleton<ComplaintRepository>(() => ComplaintApiRepository(client));
  getIt.registerLazySingleton<CreateComplaintUsecase>(() => CreateComplaintUsecase(getIt.get<ComplaintRepository>()));
}
