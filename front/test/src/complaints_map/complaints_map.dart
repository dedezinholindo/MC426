import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'data/complaints_map_api_repository_test.dart' as complaints_map_api_repository;
import 'domain/get_coordinates_usecase_test.dart' as get_coordinates_usecase;
import 'ui/complaint_map_bloc_test.dart' as complaint_map_bloc;

void main() {
  GetIt.instance.allowReassignment = true;

  group('complaints_map_api_repository', complaints_map_api_repository.main);
  group('get_coordinates_usecase', get_coordinates_usecase.main);
  group('complaint_map_bloc', complaint_map_bloc.main);
}
