part of 'user_posts_bloc.dart';

sealed class UserPostsState {}

class UserPostsLoadingState extends UserPostsState {
  UserPostsLoadingState();
}

class UserPostsLoadedState extends UserPostsState {
  final UserPostEntity userPost;

  UserPostsLoadedState(this.userPost);
}

class UserPostsEmptyState extends UserPostsState {
  UserPostsEmptyState();
}

class UserPostsErrorState extends UserPostsState {
  UserPostsErrorState();
}
