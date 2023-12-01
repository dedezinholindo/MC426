import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/home/domain/domain.dart';
import 'package:mc426_front/storage/storage.dart';

class HomeUsecase {
  final HomeRepository repository;
  final StorageInterface storage;

  const HomeUsecase(this.repository, this.storage);

  Future<HomeEntity?> call() async {
    final userId = storage.getString(userIdKey);
    if (userId == null) return null;
    return await repository.getHome(userId);
  }
}
