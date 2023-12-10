import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:mc426_front/home/home.dart';

class HomeLoadedView extends StatelessWidget {
  final HomeEntity home;
  final void Function(int id, bool vote) vote;

  const HomeLoadedView({required this.vote, required this.home, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeUserWidget(user: home.user),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: CustomFlutterMap(
              userCoordinates: LatLng(home.user.coordinates.latitude, home.user.coordinates.longitude),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Publicações",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 24),
          ...home.posts.map(
            (e) => HomePostWidget(
              post: e,
              vote: (like) {
                vote(e.id, like);
              },
            ),
          ),
        ],
      ),
    );
  }
}
