import 'package:mc426_front/profile/profile.dart';
import 'package:mc426_front/storage/storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

class ProfileRepositoryMock extends Mock implements ProfileRepository {}

class StorageInterfaceMock extends Mock implements StorageInterface {}

const userIdMock = "user_id";

void main() {
  late final ProfileRepository repository;
  late final StorageInterface storage;
  late final GetUserPostsUsecase usecase;

  setUpAll(() {
    repository = ProfileRepositoryMock();
    storage = StorageInterfaceMock();
    usecase = GetUserPostsUsecase(repository, storage);
    registerFallbackValue([userPostJson]);
  });

  group("call", () {
    test("should return list of posts when repository returns posts", () async {
      when(
        () => repository.getUserPosts(any()),
      ).thenAnswer((invocation) async => UserPostEntity.fromMap(userPostJson));

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      final result = await usecase.call();
      expect(result!.posts.length, 2);
    });

    test("should return empty list when repository returns empty list", () async {
      when(
        () => repository.getUserPosts(any()),
      ).thenAnswer((invocation) async => UserPostEntity.fromMap(userPostEmpty));

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      final result = await usecase.call();
      expect(result!.posts.isEmpty, true);
    });

    test("should return empty list when repository returns no posts", () async {
      when(
        () => repository.getUserPosts(any()),
      ).thenAnswer((invocation) async => UserPostEntity.fromMap(userPostNull));

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      final result = await usecase.call();
      expect(result!.posts.isEmpty, true);
    });

    test("should return null when repository returns null", () async {
      when(
        () => repository.getUserPosts(any()),
      ).thenAnswer((invocation) async => null);

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      final result = await usecase.call();
      expect(result, null);
    });

    test("should return null when storage returns null", () async {
      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => null);

      final result = await usecase.call();
      expect(result, null);
    });
  });
}
