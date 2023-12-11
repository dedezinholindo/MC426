import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc426_front/profile/profile.dart';
import 'package:mc426_front/profile/ui/user_posts/bloc/user_posts_bloc.dart';

class UserPostsPage extends StatefulWidget {
  static const String routeName = '/profile/posts';

  const UserPostsPage({super.key});

  @override
  State<UserPostsPage> createState() => _UserPostsPageState();
}

class _UserPostsPageState extends State<UserPostsPage> {
  final _bloc = UserPostsBloc();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _bloc.getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPostsBloc, UserPostsState>(
      bloc: _bloc,
      builder: (context, state) {
        Widget? body = switch (state) {
          UserPostsLoadingState() => const Center(child: CircularProgressIndicator()),
          UserPostsLoadedState() => UserPostsLoadedView(userPost: state.userPost),
          UserPostsEmptyState() => const UserPostEmptyView(),
          UserPostsErrorState() => const UserPostsErrorView(),
        };

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
          body: Scaffold(
            primary: false,
            body: body,
          ),
        );
      },
    );
  }
}
