import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/complaint/complaint.dart';

class ComplaintApiRepository extends ComplaintRepository {
  final http.Client client;
  ComplaintApiRepository(this.client);

  @override
  Future<ComplaintResult> createComplaint(Complaint complaint) async {
    try {
      final result = await client.post(
        Uri.parse("${baseUrl}complaints"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(complaint.toMap()),
      );

      if (result.statusCode != 201) {
        final responseJson = jsonDecode(result.body);
        return ComplaintResult(
          isSuccess: false,
          message: "Falha ao criar denúncia: ${responseJson['error'] ?? 'Erro desconhecido'}",
        );
      }

      await client.post(
        Uri.parse("https://fcm.googleapis.com/v1/projects/press2safe/messages:send"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ya29.a0AfB_byD3-TndmqLAbBP3s_7lkKBCQiMlqrypWj1c5DKEY-9IWoqTmFcQddrE4VLgFiY95y6qY4h7CmIrQB7gXijcFtoXoZX7teN_vwVgXhwm89a29s2c3MDlloEx64MSBHINgui4MW44ZyQmtEL0uSLbS3LwsVBjk0XxaCgYKAbkSARESFQHGX2MiZTkSlI-P3TNau5vCX8SC2w0171',
        },
        body: jsonEncode({
          "message": {
            "topic": "new_post_topic",
            "notification": {
              "title": "Nova publicação",
              "body": "Uma nova denúncia foi publicada! Acesse o app e mantenha-se informado das ocorrências próximas a sua área"
            }
          }
        }),
      );

      return const ComplaintResult(
        isSuccess: true,
        message: "Denúncia criada com sucesso!",
      );
    } catch (e) {
      return ComplaintResult(isSuccess: false, message: "Não foi possível concluir a solicitação: $e");
    }
  }
}
