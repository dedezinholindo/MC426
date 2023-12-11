import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/home/home.dart';

class SendLocationApiRepository extends SendLocationRepository {
  final http.Client client;

  SendLocationApiRepository(this.client);

  @override
  Future<bool> sendPanicLocation(LatLng position) async {
    try {
      var url = Uri.parse('$baseUrl/api/send_panic_location');
      final result = await client.post(
        url,
        body: jsonEncode({
          'latitude': position.latitude,
          'longitude': position.longitude,
        }),
      );

      log("Response status: ${result.statusCode}");
      log("Response body: ${result.body}");

      return result.statusCode == 200;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
