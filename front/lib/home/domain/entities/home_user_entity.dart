import 'package:latlong2/latlong.dart';

class HomeUserEntity {
  final String username;
  final String? photo;
  final String? safetyNumber;
  final LatLng coordinates;
  final int qtdPosts;

  const HomeUserEntity({
    this.safetyNumber,
    required this.username,
    required this.qtdPosts,
    required this.coordinates,
    this.photo,
  });

  factory HomeUserEntity.fromMap(Map<String, dynamic> map) {
    return HomeUserEntity(
      safetyNumber: map["safetyNumber"],
      username: map["username"],
      photo: map["photo"],
      qtdPosts: map["numberOfPosts"] ?? 0,
      coordinates:
          map["location"] != null ? LatLng(map["location"]["latitude"] ?? 0, map["location"]["longitude"] ?? 0) : const LatLng(0, 0),
    );
  }
}
