import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/profile/profile.dart';
import 'package:mc426_front/profile/ui/user_posts/bloc/user_posts_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

class GetUserPostsUsecaseMock extends Mock implements GetUserPostsUsecase {}

void main() {
  late final GetUserPostsUsecase getUserPostsUsecase;

  setUpAll(() {
    final injection = GetIt.instance;
    getUserPostsUsecase = GetUserPostsUsecaseMock();

    injection.registerFactory<GetUserPostsUsecase>(() => getUserPostsUsecase);
  });

  group("getPosts", () {
    blocTest<UserPostsBloc, UserPostsState>(
      'should emit Loaded State when the request is completed',
      build: () {
        when(() => getUserPostsUsecase.call()).thenAnswer((_) async => UserPostEntity.fromMap(userPostJson));
        return UserPostsBloc();
      },
      act: (bloc) async {
        await bloc.getPosts();
      },
      expect: () => [
        isA<UserPostsLoadingState>(),
        isA<UserPostsLoadedState>().having((s) => s.userPost.posts.first.id, "user_post_id", 1),
      ],
    );

    blocTest<UserPostsBloc, UserPostsState>(
      'should emit Empty State when the request is completed and returns empty list',
      build: () {
        when(() => getUserPostsUsecase.call()).thenAnswer((_) async => UserPostEntity.fromMap(userPostEmpty));
        return UserPostsBloc();
      },
      act: (bloc) async {
        await bloc.getPosts();
      },
      expect: () => [
        isA<UserPostsLoadingState>(),
        isA<UserPostsEmptyState>(),
      ],
    );

    blocTest<UserPostsBloc, UserPostsState>(
      'should emit Error State when the request returns null',
      build: () {
        when(() => getUserPostsUsecase.call()).thenAnswer((_) async => null);
        return UserPostsBloc();
      },
      act: (bloc) async {
        await bloc.getPosts();
      },
      expect: () => [
        isA<UserPostsLoadingState>(),
        isA<UserPostsErrorState>(),
      ],
    );

    blocTest<UserPostsBloc, UserPostsState>(
      'should emit Error State fails when request fails',
      build: () {
        when(() => getUserPostsUsecase.call()).thenThrow(Exception());
        return UserPostsBloc();
      },
      act: (bloc) async {
        await bloc.getPosts();
      },
      expect: () => [
        isA<UserPostsLoadingState>(),
        isA<UserPostsErrorState>(),
      ],
    );
  });
}
