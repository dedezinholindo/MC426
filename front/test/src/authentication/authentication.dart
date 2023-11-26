import 'package:get_it/get_it.dart';
import 'package:test/test.dart';

import 'data/authentication_api_repository_test.dart' as authentication_api_repository;
import 'domain/sign_in_entity_test.dart' as sign_in_entity;
import 'domain/sign_in_usecase_test.dart' as sign_in_usecase;
import 'domain/sign_up_entity_test.dart' as sign_up_entity;
import 'domain/sign_up_usecase_test.dart' as sign_up_usecase;
import 'ui/sign_in_bloc_test.dart' as sign_in_bloc;
import 'ui/sign_up_bloc_test.dart' as sign_up_bloc;

void main() {
  GetIt.instance.allowReassignment = true;

  group('authentication_api_repository', authentication_api_repository.main);
  group('sign_in_entity', sign_in_entity.main);
  group('sign_in_usecase', sign_in_usecase.main);
  group('sign_up_entity', sign_up_entity.main);
  group('sign_up_usecase', sign_up_usecase.main);
  group('sign_in_bloc', sign_in_bloc.main);
  group('sign_up_bloc', sign_up_bloc.main);
}
