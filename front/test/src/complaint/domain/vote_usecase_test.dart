import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mc426_front/complaint/domain/usecases/vote_usecase.dart';
import 'package:mc426_front/complaint/domain/repositories/vote_repository.dart';

class MockVoteRepository extends Mock implements VoteRepository {}

void main() {
  group('VoteUsecase', () {
    test('call should invoke upvote', () async {
      final repository = MockVoteRepository();
      final usecase = VoteUseCase(repository);

      when(() => repository.vote(any(), true))
          .thenAnswer((_) async => true);

      final result = await usecase.call(1, true);
      expect(result, isTrue);
    });

    test('call should fail on upvote error', () async {
      final repository = MockVoteRepository();
      final usecase = VoteUseCase(repository);
      
      when(() => repository.vote(any(), true))
          .thenAnswer((_) async => false);

      final result = await usecase.call(1, true);
      expect(result, isFalse);
    });

    test('call should invoke downvote', () async {
      final repository = MockVoteRepository();
      final usecase = VoteUseCase(repository);

      when(() => repository.vote(any(), false))
          .thenAnswer((_) async => true);

      final result = await usecase.call(1, false);
      expect(result, isTrue);
    });
    test('call should fail on downvote error', () async {
      final repository = MockVoteRepository();
      final usecase = VoteUseCase(repository);

      when(() => repository.vote(any(), false))
          .thenAnswer((_) async => false);

      final result = await usecase.call(1, false);
      expect(result, isFalse);
    });
  });
}
