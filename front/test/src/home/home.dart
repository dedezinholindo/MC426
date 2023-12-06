import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'data/home_api_repository_test.dart' as home_api_repository;
import 'domain/get_home_usecase_test.dart' as home_usecase;
import 'domain/home_entity_test.dart' as home_entity;
import 'domain/home_post_entity_test.dart' as home_post_entity;
import 'domain/home_user_entity_test.dart' as home_user_entity;
import 'ui/home_bloc_test.dart' as home_bloc;

void main() {
  GetIt.instance.allowReassignment = true;

  group('home_api_repository', home_api_repository.main);
  group('home_entity', home_entity.main);
  group('home_post_entity', home_post_entity.main);
  group('home_user_entity', home_user_entity.main);
  group('home_usecase', home_usecase.main);
  group('home_bloc', home_bloc.main);
}
