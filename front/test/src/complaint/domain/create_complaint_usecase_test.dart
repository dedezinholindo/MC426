import 'package:mc426_front/complaint/complaint.dart';
import 'package:mc426_front/storage/storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

class ComplaintRepositoryMock extends Mock implements ComplaintRepository {}

class StorageInterfaceMock extends Mock implements StorageInterface {}

const userIdMock = "user_id";

void main() {
  late final StorageInterface storage;
  late final ComplaintRepository repository;
  late final CreateComplaintUsecase usecase;

  setUpAll(() {
    repository = ComplaintRepositoryMock();
    storage = StorageInterfaceMock();
    usecase = CreateComplaintUsecase(repository, storage);
    registerFallbackValue(mockComplaint);
  });

  group("call", () {
    test("should return ComplaintResult success when repository is successful", () async {
      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      when(
        () => repository.createComplaint(userId: any(named: "userId"), complaint: any(named: "complaint")),
      ).thenAnswer((invocation) async => const ComplaintResult(
            isSuccess: true,
            message: "Denúncia criada com sucesso",
          ));

      final result = await usecase.call(mockComplaint);
      expect(result.isSuccess, true);
      expect(result.message, "Denúncia criada com sucesso");
    });

    test("should return ComplaintResult failure when repository fails", () async {
      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      when(
        () => repository.createComplaint(userId: any(named: "userId"), complaint: any(named: "complaint")),
      ).thenAnswer((invocation) async => const ComplaintResult(
            isSuccess: false,
            message: "Falha ao criar denúncia",
          ));

      final result = await usecase.call(mockComplaint);
      expect(result.isSuccess, false);
      expect(result.message, "Falha ao criar denúncia");
    });

    test("should return ComplaintResult failure when storage returns null", () async {
      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => null);

      final result = await usecase.call(mockComplaint);
      expect(result.isSuccess, false);
      expect(result.message, "Falha ao criar denúncia");
    });

    test("should throw Exception when repository throws Exception", () async {
      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      when(
        () => repository.createComplaint(userId: any(named: "userId"), complaint: any(named: "complaint")),
      ).thenThrow(Exception());

      expect(
        () => usecase.call(mockComplaint),
        throwsA(
          isA<Exception>(),
        ),
      );
    });
  });
}
