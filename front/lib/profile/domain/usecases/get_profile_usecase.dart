import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/profile/domain/domain.dart';
import 'package:mc426_front/storage/storage.dart';

class GetProfileUsecase {
  final ProfileRepository repository;
  final StorageInterface storage;

  const GetProfileUsecase(this.repository, this.storage);

  Future<ProfileEntity?> call() async {
    final userId = storage.getString(userIdKey);
    if (userId == null) return null;
    return await repository.getProfile(userId);
  }
}
