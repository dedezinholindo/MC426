class UserPostHeaderEntity {
  final String? photo;
  final String name;

  const UserPostHeaderEntity({
    required this.name,
    this.photo,
  });

  factory UserPostHeaderEntity.fromMap(Map<String, dynamic> map) {
    return UserPostHeaderEntity(
      photo: map["photo"],
      name: map["name"],
    );
  }
}
