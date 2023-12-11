class ProfileEntity {
  final String name;
  final String username;
  final String email;
  final String phone;
  final String address;
  final String? photo;
  final String? safetyNumber;
  final int age;

  const ProfileEntity({
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.address,
    required this.age,
    this.photo,
    this.safetyNumber,
  });

  factory ProfileEntity.fromMap(Map<String, dynamic> map) {
    return ProfileEntity(
      name: map["name"],
      username: map["username"],
      email: map["email"],
      age: map["age"],
      phone: map["phone"],
      address: map["address"],
      photo: map["photo"],
      safetyNumber: map["safetyNumber"],
    );
  }

  factory ProfileEntity.empty() => const ProfileEntity(
        name: "",
        username: "",
        email: "",
        age: 0,
        phone: "",
        address: "",
      );

  Map<String, dynamic> get toMap => {
        "name": name,
        "username": username,
        "email": email,
        "age": age,
        "phone": phone,
        "address": address,
        "photo": photo,
        "safetyNumber": safetyNumber,
      };

  ProfileEntity copyWith({
    String? name,
    String? username,
    String? email,
    String? phone,
    String? address,
    String? photo,
    String? safetyNumber,
    int? age,
  }) {
    return ProfileEntity(
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      age: age ?? this.age,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      photo: photo ?? this.photo,
      safetyNumber: safetyNumber ?? this.safetyNumber,
    );
  }
}
