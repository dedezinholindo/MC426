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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: _bloc,
      builder: (context, state) {
        Widget? body = HomeLoadedView(
          home: const HomeEntity(
              user: HomeUserEntity(
                safetyNumber: "1234",
                username: "Isabela",
                photo: null,
                qtdPosts: 3,
                coordinates: Coordinates(
                  latitude: -22.8184343,
                  longitude: -47.0695915,
                ),
              ),
              posts: [
                HomePostEntity(
                  id: 1,
                  description:
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived.",
                  name: "Isabela",
                  upVotes: 2,
                  downVotes: 3,
                  time: "2 horas",
                  userUpVoted: false,
                  userDownVoted: false,
                  local: "Localização",
                  isAnonymous: true,
                ),
                HomePostEntity(
                  id: 1,
                  description:
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived.",
                  name: "Isabela",
                  upVotes: 2,
                  downVotes: 3,
                  time: "2 horas",
                  userUpVoted: false,
                  userDownVoted: false,
                  local: "Localização",
                  isAnonymous: true,
                )
              ]),
          vote: (int id, bool vote) {},
        );

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
