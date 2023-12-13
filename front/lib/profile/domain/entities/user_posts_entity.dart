import 'package:mc426_front/profile/profile.dart';

class UserPostEntity {
  final UserPostHeaderEntity header;
  final List<UserPostInfoEntity> posts;

  const UserPostEntity({
    required this.header,
    required this.posts,
  });

  factory UserPostEntity.fromMap(Map<String, dynamic> map) {
    final header = UserPostHeaderEntity.fromMap(Map<String, dynamic>.from(map["header"]));
    final posts = map['complaints'] != null
        ? List<UserPostInfoEntity>.from(map['complaints'].map((e) => UserPostInfoEntity.fromMap(Map<String, dynamic>.from(e)))).toList()
        : <UserPostInfoEntity>[];

    return UserPostEntity(
      header: header,
      posts: posts,
    );
  }
}
