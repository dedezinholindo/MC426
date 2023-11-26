import 'package:get_it/get_it.dart';
import 'package:test/test.dart';

import 'data/complaint_api_repository_test.dart' as complaint_api_repository_test;
import 'domain/complaint_entity_test.dart' as complaint_entity;
import 'domain/create_complaint_usecase_test.dart' as create_complaint_usecase;
import 'ui/complaint_bloc_test.dart' as complaint_bloc;

void main() {
  GetIt.instance.allowReassignment = true;

  group('complaint_api_repository_test', complaint_api_repository_test.main);
  group('complaint_entity', complaint_entity.main);
  group('create_complaint_usecase', create_complaint_usecase.main);
  group('complaint_bloc', complaint_bloc.main);
}
