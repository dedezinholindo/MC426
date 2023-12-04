import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/profile/domain/domain.dart';

part 'user_posts_states.dart';

class UserPostsBloc extends Cubit<UserPostsState> {
  UserPostsBloc() : super(UserPostsLoadingState());

  final getPostsUsecase = GetIt.instance.get<GetUserPostsUsecase>();

  Future<void> getPosts() async {
    emit(UserPostsLoadingState());
    try {
      final result = await getPostsUsecase.call();
      if (result == null) return emit(UserPostsErrorState());
      if (result.posts.isEmpty) return emit(UserPostsEmptyState());
      emit(UserPostsLoadedState(result));
    } catch (e) {
      emit(UserPostsErrorState());
    }
  }
}
