import 'package:get_it/get_it.dart';
import 'package:test/test.dart';

import 'data/profile_api_repository_test.dart' as profile_api_repository;
import 'domain/edit_profile_usecase_test.dart' as edit_profile_usecase;
import 'domain/get_profile_usecase_test.dart' as get_profile_usecase;
import 'domain/get_user_posts_usecase_test.dart' as get_user_posts_usecase;
import 'domain/profile_entity_test.dart' as profile_entity;
import 'domain/user_posts_entity_test.dart' as user_posts_entity;
import 'domain/user_posts_header_entity_test.dart' as user_posts_header_entity;
import 'domain/user_posts_info_entity_test.dart' as user_posts_info_entity;
import 'ui/profile_bloc_test.dart' as profile_bloc;
import 'ui/user_posts_bloc_test.dart' as user_posts_bloc;

void main() {
  GetIt.instance.allowReassignment = true;

  group('profile_api_repository', profile_api_repository.main);
  group('profile_entity', profile_entity.main);
  group('get_profile_usecase', get_profile_usecase.main);
  group('edit_profile_usecase', edit_profile_usecase.main);
  group('get_user_posts_usecase', get_user_posts_usecase.main);
  group('profile_bloc', profile_bloc.main);
  group('user_posts_bloc', user_posts_bloc.main);
  group('user_posts_entity', user_posts_entity.main);
  group('user_posts_header_entity', user_posts_header_entity.main);
  group('user_posts_info_entity', user_posts_info_entity.main);
}
