import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/profile/domain/domain.dart';
import 'package:mc426_front/storage/storage.dart';

class GetUserPostsUsecase {
  final ProfileRepository repository;
  final StorageInterface storage;

  const GetUserPostsUsecase(this.repository, this.storage);

  Future<UserPostEntity?> call() async {
    final userId = storage.getString(userIdKey);
    if (userId == null) return null;
    return await repository.getUserPosts(userId);
  }
}
