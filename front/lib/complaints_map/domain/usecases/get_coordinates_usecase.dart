import 'package:latlong2/latlong.dart';
import 'package:mc426_front/complaints_map/complaints_map.dart';

class GetCoordinatesUsecase {
  final ComplaintsMapRepository repository;

  const GetCoordinatesUsecase(this.repository);

  Future<List<LatLng>?> call() async {
    return await repository.getCoordinates();
  }
}
