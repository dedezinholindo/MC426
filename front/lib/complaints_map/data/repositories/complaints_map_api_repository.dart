import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/complaints_map/complaints_map.dart';

class ComplaintsMapApiRepository extends ComplaintsMapRepository {
  final http.Client client;
  ComplaintsMapApiRepository(this.client);

  @override
  Future<List<LatLng>?> getCoordinates() async {
    try {
      final result = await client.get(
        Uri.parse("${baseUrl}geocode"),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      final body = jsonDecode(result.body);

      if (result.statusCode != 200) return null;

      final coordinates = body != null ? List<LatLng>.from(body.map((e) => LatLng(e["latitude"], e["longitude"]))).toList() : <LatLng>[];

      return coordinates;
    } catch (e) {
      return null;
    }
  }
}
