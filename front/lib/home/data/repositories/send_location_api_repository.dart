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
              'Bearer ya29.a0AfB_byD3-TndmqLAbBP3s_7lkKBCQiMlqrypWj1c5DKEY-9IWoqTmFcQddrE4VLgFiY95y6qY4h7CmIrQB7gXijcFtoXoZX7teN_vwVgXhwm89a29s2c3MDlloEx64MSBHINgui4MW44ZyQmtEL0uSLbS3LwsVBjk0XxaCgYKAbkSARESFQHGX2MiZTkSlI-P3TNau5vCX8SC2w0171',
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
