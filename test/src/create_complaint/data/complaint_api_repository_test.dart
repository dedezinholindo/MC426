import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mc426_front/Create_Complaint/data/repositories/complaint_api_repository.dart';
import 'package:mc426_front/Create_Complaint/domain/entities/complaint.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
//import '../mocks/mocks.dart';

class ClientMock extends Mock implements http.Client {}

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
          jsonEncode({"message": "Complaint created successfully"}),
          201,
        ),
      );

      final result = await repository.createComplaint(mockComplaint);
      expect(result.isSuccess, true);
      expect(result.message, "Complaint created successfully");
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
          jsonEncode({"message": "Failed to create complaint"}),
          400,
        ),
      );

      final result = await repository.createComplaint(mockComplaint);
      expect(result.isSuccess, false);
      expect(result.message, "Failed to create complaint");
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

      final result = await repository.createComplaint(mockComplaint);
      expect(result.isSuccess, false);
      expect(result.message, "Unable to complete the request");
    });
  });
}