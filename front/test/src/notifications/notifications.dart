import 'package:get_it/get_it.dart';
import 'package:test/test.dart';

import 'data/notifications_api_repository_test.dart' as notifications_api_repository;
import 'domain/change_notifications_usecase_test.dart' as edit_notifications_usecase;
import 'domain/get_notifications_usecase_test.dart' as get_notifications_usecase;
import 'domain/notification_entity_test.dart' as notification_entity;
import 'ui/notification_bloc_test.dart' as notification_bloc;

void main() {
  GetIt.instance.allowReassignment = true;

  group('notifications_api_repository', notifications_api_repository.main);
  group('edit_notifications_usecase', edit_notifications_usecase.main);
  group('get_notifications_usecase', get_notifications_usecase.main);
  group('notification_entity', notification_entity.main);
  group('notifications_api_repository', notifications_api_repository.main);
  group('notification_bloc', notification_bloc.main);
}
