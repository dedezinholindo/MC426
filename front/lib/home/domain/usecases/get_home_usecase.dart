import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/home/domain/domain.dart';
import 'package:mc426_front/storage/storage.dart';

class GetHomeUsecase {
  final HomeRepository repository;
  final StorageInterface storage;

  const GetHomeUsecase(this.repository, this.storage);

  Future<HomeEntity?> call() async {
    final userId = storage.getString(userIdKey);
    if (userId == null) return null;

    final home = await repository.getHome(userId);
    if (home == null) return home;

    await storage.setString(safetyNumberKey, home.user.safetyNumber);
    return home;
  }
}
