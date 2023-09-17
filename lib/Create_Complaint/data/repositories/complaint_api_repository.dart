import 'package:mc426_front/Create_Complaint/complaint.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mc426_front/common/common.dart';

class ComplaintApiRepository extends ComplaintRepository {
  final http.Client client;
  ComplaintApiRepository(this.client);

  @override
  Future<ComplaintResult> createComplaint(Complaint complaint) async {
    try {
    final result = await client.post(
      Uri.parse("${BASE_URL}login"),
      headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(complaint.toMap()), 
      );

      if (result.statusCode == 201) {
        return ComplaintResult(
          isSuccess: true,
          message: "Denúncia criada com sucesso!",
          complaint: Complaint.fromMap(jsonDecode(result.body))
        );
      } else {
        return const ComplaintResult(
          isSuccess: false,
          message: "Falha ao criar denúncia"
        );
      }

    } catch (e) {
      return ComplaintResult(
        isSuccess: false,
        message: "Não foi possível concluir a solicitação: $e"
      );
    }
  }
}