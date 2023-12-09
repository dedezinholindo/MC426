import 'package:get_it/get_it.dart';
import 'package:test/test.dart';

import 'data/profile_api_repository_test.dart' as profile_api_repository;
import 'domain/edit_profile_usecase_test.dart' as edit_profile_usecase;
import 'domain/get_profile_usecase_test.dart' as get_profile_usecase;
import 'domain/profile_entity_test.dart' as profile_entity;
import 'ui/profile_bloc_test.dart' as profile_bloc;

void main() {
  GetIt.instance.allowReassignment = true;

  group('profile_api_repository', profile_api_repository.main);
  group('profile_entity', profile_entity.main);
  group('get_profile_usecase', get_profile_usecase.main);
  group('edit_profile_usecase', edit_profile_usecase.main);
  group('profile_bloc', profile_bloc.main);
}
