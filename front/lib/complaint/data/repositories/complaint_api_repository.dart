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

      if (result.statusCode == 201) {
        return const ComplaintResult(
          isSuccess: true,
          message: "Denúncia criada com sucesso!",
        );
      } else {
        var responseJson = jsonDecode(result.body);
        return ComplaintResult(
          isSuccess: false,
          message: "Falha ao criar denúncia: ${responseJson['error'] ?? 'Erro desconhecido'}",
        );
      }
    } catch (e) {
      return ComplaintResult(isSuccess: false, message: "Não foi possível concluir a solicitação: $e");
    }
  }
}
