import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/complaint/complaint.dart';

class ComplaintApiRepository extends ComplaintRepository {
  final http.Client client;
  ComplaintApiRepository(this.client);

  @override
  Future<ComplaintResult> createComplaint({required String userId, required Complaint complaint}) async {
    try {
      final result = await client.post(
        Uri.parse("${baseUrl}complaints/$userId"),
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
              'Bearer ya29.a0AfB_byCFEDLQtwKQNG6cWIUrCPpZ6jP-Ok5--xMvbDbAdBDeG1AUjvhMaBaKs8gz8SGwEbD2X5WljdB_uTqQsdcH5DaOrn2SqQuC1-w755NvstHyxwNtFnxlUn9bRA8F6hEUE_Wvjc7wjWbiha7ZVfaQHfhUszsDJjsuaCgYKAVISARESFQHGX2MiDvFEEz3XSokw30vd24_Dlw0171',
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
