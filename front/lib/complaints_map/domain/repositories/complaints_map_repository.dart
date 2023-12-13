import 'package:latlong2/latlong.dart';

abstract class ComplaintsMapRepository {
  Future<List<LatLng>?> getCoordinates();
}
