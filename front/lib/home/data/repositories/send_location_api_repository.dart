import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:mc426_front/home/home.dart';

class SendLocationApiRepository extends SendLocationRepository {
  final http.Client client;

  SendLocationApiRepository(this.client);

  @override
  Future<bool> sendPanicLocation(LatLng position) async {
    try {
      final result = await client.post(
        Uri.parse("https://fcm.googleapis.com/v1/projects/press2safe/messages:send"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ya29.a0AfB_byCFEDLQtwKQNG6cWIUrCPpZ6jP-Ok5--xMvbDbAdBDeG1AUjvhMaBaKs8gz8SGwEbD2X5WljdB_uTqQsdcH5DaOrn2SqQuC1-w755NvstHyxwNtFnxlUn9bRA8F6hEUE_Wvjc7wjWbiha7ZVfaQHfhUszsDJjsuaCgYKAVISARESFQHGX2MiDvFEEz3XSokw30vd24_Dlw0171',
        },
        body: jsonEncode({
          "message": {
            "topic": "sos_message_topic",
            "notification": {
              "title": "SOS",
              "body": "Alguém está precisando de ajuda, encontre a pessoa em: (${position.latitude}, ${position.longitude})",
            }
          }
        }),
      );

      return result.statusCode == 200;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
