import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:humanitarian_icons/humanitarian_icons.dart';
import 'package:mc426_front/authentication/authentication.dart';
import 'package:mc426_front/home/home.dart';
import 'package:mc426_front/home/ui/bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = HomeBloc();

  void _logout() {
    _bloc.logout();
    Navigator.of(context).pushNamedAndRemoveUntil(SignInPage.routeName, (route) => true);
  }

  Future<void> configurePush() async {
    final notifications = await _bloc.getNotificationUsecase.call();
    notifications?.forEach((e) async {
      await FirebaseMessaging.instance.subscribeToTopic(e.topicName);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _bloc.init();
      await configurePush();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: _bloc,
      builder: (context, state) {
        Widget? body = switch (state) {
          HomeLoadingState() => const Center(child: CircularProgressIndicator()),
          HomeLoadedState() => HomeLoadedView(
              home: state.home,
              vote: _bloc.vote,
            ),
          HomeErrorState() => const HomeErrorView(),
        };

        return Scaffold(
          drawerEnableOpenDragGesture: false,
          drawer: HomeDrawer(logout: _logout),
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              HumanitarianIcons.police_station,
            ),
          ),
          body: body,
        );
      },
    );
  }
}
