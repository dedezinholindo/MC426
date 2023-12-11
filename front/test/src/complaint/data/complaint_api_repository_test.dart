import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mc426_front/complaint/data/repositories/complaint_api_repository.dart';
import 'package:mc426_front/complaint/domain/entities/complaint.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class ClientMock extends Mock implements http.Client {}

const userIdMock = "user_id";

void main() {
  late final http.Client client;
  late final ComplaintApiRepository repository;

  setUpAll(() {
    client = ClientMock();
    repository = ComplaintApiRepository(client);
    registerFallbackValue(Uri());
  });

  group("createComplaint", () {
    test("should return Complaint result success when request is successful", () async {
      final mockComplaint = Complaint(title: 'Test Title', description: 'Test Description', address: 'Test Address', isAnonymous: false);

      when(
        () => client.post(
          any(),
          body: any(named: "body"),
          headers: any(named: "headers"),
        ),
      ).thenAnswer(
        (invocation) async => http.Response(
          jsonEncode({"mensagem": "Denúncia criada com sucesso!"}),
          201,
        ),
      );

      final result = await repository.createComplaint(userId: userIdMock, complaint: mockComplaint);
      expect(result.isSuccess, true);
      expect(result.message, "Denúncia criada com sucesso!");
    });

    test("should return Complaint result fails when request fails", () async {
      final mockComplaint = Complaint(title: 'Test Title', description: 'Test Description', address: 'Test Address', isAnonymous: false);

      when(
        () => client.post(
          any(),
          body: any(named: "body"),
          headers: any(named: "headers"),
        ),
      ).thenAnswer(
        (invocation) async => http.Response(
          jsonEncode({"mensagem": "Falha ao criar denúncia"}),
          400,
        ),
      );

      final result = await repository.createComplaint(userId: userIdMock, complaint: mockComplaint);
      expect(result.isSuccess, false);
      expect(result.message, "Falha ao criar denúncia: Erro desconhecido");
    });

    test("should return Complaint result fails when request throws Exception", () async {
      final mockComplaint = Complaint(title: 'Test Title', description: 'Test Description', address: 'Test Address', isAnonymous: false);

      when(
        () => client.post(
          any(),
          body: any(named: "body"),
          headers: any(named: "headers"),
        ),
      ).thenThrow(Exception());

      final result = await repository.createComplaint(userId: userIdMock, complaint: mockComplaint);
      expect(result.isSuccess, false);
      expect(result.message, "Não foi possível concluir a solicitação: ${Exception()}");
    });
  });
}
