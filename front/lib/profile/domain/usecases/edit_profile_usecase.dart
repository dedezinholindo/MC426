import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/profile/domain/domain.dart';
import 'package:mc426_front/storage/storage.dart';

class EditProfileUsecase {
  final ProfileRepository repository;
  final StorageInterface storage;

  const EditProfileUsecase(this.repository, this.storage);

  Future<bool> call(ProfileEntity profile) async {
    final userId = storage.getString(userIdKey);
    if (userId == null) return false;
    return await repository.edit(profile: profile, userId: userId);
  }
}
