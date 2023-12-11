import 'package:mc426_front/complaint/complaint.dart';
import 'package:mc426_front/storage/storage_interface.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class VoteRepositoryMock extends Mock implements VoteRepository {}

class StorageInterfaceMock extends Mock implements StorageInterface {}

const userIdMock = "user_id";

void main() {
  late final StorageInterface storage;
  late final VoteRepository repository;
  late final VoteUseCase usecase;

  setUpAll(() {
    repository = VoteRepositoryMock();
    storage = StorageInterfaceMock();
    usecase = VoteUseCase(repository, storage);
  });

  group('call', () {
    test('should invoke upvote', () async {
      when(() => repository.vote(userId: any(named: "userId"), complaintId: any(named: "complaintId"), upvote: true))
          .thenAnswer((_) async => true);

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      final result = await usecase.call(1, true);
      expect(result, isTrue);
    });

    test('should fail on upvote error', () async {
      when(() => repository.vote(userId: any(named: "userId"), complaintId: any(named: "complaintId"), upvote: true))
          .thenAnswer((_) async => false);

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      final result = await usecase.call(1, true);
      expect(result, isFalse);
    });

    test('should invoke downvote', () async {
      when(() => repository.vote(userId: any(named: "userId"), complaintId: any(named: "complaintId"), upvote: false))
          .thenAnswer((_) async => true);

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      final result = await usecase.call(1, false);
      expect(result, isTrue);
    });

    test('should fail on downvote error', () async {
      when(() => repository.vote(userId: any(named: "userId"), complaintId: any(named: "complaintId"), upvote: false))
          .thenAnswer((_) async => false);

      final result = await usecase.call(1, false);
      expect(result, isFalse);
    });

    test('should fail when storage returns null', () async {
      when(() => repository.vote(userId: any(named: "userId"), complaintId: any(named: "complaintId"), upvote: false))
          .thenAnswer((_) async => false);

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => null);

      final result = await usecase.call(1, false);
      expect(result, isFalse);
    });
  });
}
