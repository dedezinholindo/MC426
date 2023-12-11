import 'package:latlong2/latlong.dart';
import 'package:mc426_front/home/home.dart';

class SendPanicLocationUsecase {
  final SendLocationRepository repository;

  SendPanicLocationUsecase(this.repository);

  Future<bool> call(LatLng position) async {
    return await repository.sendPanicLocation(position);
  }
}