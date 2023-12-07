import 'package:latlong2/latlong.dart';
import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/complaints_map/complaints_map.dart';
import 'package:mc426_front/storage/storage.dart';

class GetCoordinatesUsecase {
  final ComplaintsMapRepository repository;
  final StorageInterface storage;

  const GetCoordinatesUsecase(this.repository, this.storage);

  Future<List<LatLng>?> call() async {
    final userId = storage.getString(userIdKey);
    // if (userId == null) return null;

    return await repository.getCoordinates(userId ?? "");
  }
}
