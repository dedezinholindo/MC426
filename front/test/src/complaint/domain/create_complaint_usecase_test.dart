import 'package:mc426_front/complaint/complaint.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

class ComplaintRepositoryMock extends Mock implements ComplaintRepository {}

void main() {
  late final ComplaintRepository repository;
  late final CreateComplaintUsecase usecase;

  setUpAll(() {
    repository = ComplaintRepositoryMock();
    usecase = CreateComplaintUsecase(repository);
    registerFallbackValue(mockComplaint);
  });

  group("call", () {
    test("should return ComplaintResult success when repository is successful", () async {
      when(
        () => repository.createComplaint(any()),
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
        () => repository.createComplaint(any()),
      ).thenAnswer((invocation) async => const ComplaintResult(
            isSuccess: false,
            message: "Falha ao criar denúncia",
          ));

      final result = await usecase.call(mockComplaint);
      expect(result.isSuccess, false);
      expect(result.message, "Falha ao criar denúncia");
    });

    test("should throw Exception when repository throws Exception", () async {
      when(
        () => repository.createComplaint(any()),
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
