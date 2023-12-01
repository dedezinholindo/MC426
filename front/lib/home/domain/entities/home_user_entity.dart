class HomeUserEntity {
  final String safetyNumber;
  final String username;
  final String? photo;
  final Coordinates coordinates;
  final int qtdPosts;

  const HomeUserEntity({
    required this.safetyNumber,
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
      qtdPosts: map["qtdPosts"] ?? 0,
      coordinates: map["coordinates"] != null ? Coordinates.fromMap(Map<String, dynamic>.from(map["coordinates"])) : Coordinates.empty(),
    );
  }
}

class Coordinates {
  final double latitude;
  final double longitude;

  const Coordinates({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinates.empty() => const Coordinates(latitude: 0, longitude: 0);

  factory Coordinates.fromMap(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );
}
