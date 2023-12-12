import 'package:latlong2/latlong.dart';

abstract class SendLocationRepository {
  Future<bool> sendPanicLocation(LatLng position);
}