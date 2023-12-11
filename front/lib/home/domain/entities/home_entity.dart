import 'package:mc426_front/home/domain/domain.dart';

class HomeEntity {
  final HomeUserEntity user;
  final List<HomePostEntity> posts;

  const HomeEntity({
    required this.user,
    required this.posts,
  });

  factory HomeEntity.fromMap(Map<String, dynamic> map) {
    final user = HomeUserEntity.fromMap(Map<String, dynamic>.from(map["user"]));
    final posts = map['posts'] != null
        ? List<HomePostEntity>.from(map['posts'].map((e) => HomePostEntity.fromMap(Map<String, dynamic>.from(e)))).toList()
        : <HomePostEntity>[];

    return HomeEntity(
      user: user,
      posts: posts,
    );
  }
}
