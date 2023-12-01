import 'package:get_it/get_it.dart';
import 'package:test/test.dart';

import 'data/complaint_api_repository_test.dart' as complaint_api_repository_test;
import 'domain/complaint_entity_test.dart' as complaint_entity;
import 'domain/create_complaint_usecase_test.dart' as create_complaint_usecase;
import 'ui/complaint_bloc_test.dart' as complaint_bloc;
import 'data/vote_api_repository_test.dart' as vote_api_repository_test;
import 'domain/vote_usecase_test.dart' as vote_usecase;

void main() {
  GetIt.instance.allowReassignment = true;

  group('complaint_api_repository_test', complaint_api_repository_test.main);
  group('complaint_entity', complaint_entity.main);
  group('create_complaint_usecase', create_complaint_usecase.main);
  group('complaint_bloc', complaint_bloc.main);
  group('vote_api_repository_test', vote_api_repository_test.main);
  group('vote_usecase', vote_usecase.main);

}