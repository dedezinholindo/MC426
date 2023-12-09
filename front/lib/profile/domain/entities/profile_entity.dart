class ProfileEntity {
  final String name;
  final String username;
  final String email;
  final String age;
  final String phone;
  final String password;
  final String address;
  final String? photo;
  final String? safetyNumber;

  const ProfileEntity({
    required this.name,
    required this.username,
    required this.email,
    required this.age,
    required this.phone,
    required this.password,
    required this.address,
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
      password: map["password"],
      address: map["address"],
      photo: map["photo"],
      safetyNumber: map["safetyNumber"],
    );
  }

  factory ProfileEntity.empty() => const ProfileEntity(
        name: "",
        username: "",
        email: "",
        age: "",
        phone: "",
        password: "",
        address: "",
      );

  Map<String, dynamic> get toMap => {
        "name": name,
        "username": username,
        "email": email,
        "age": age,
        "phone": phone,
        "password": password,
        "address": address,
        "photo": photo,
        "safetyNumber": safetyNumber,
      };

  ProfileEntity copyWith({
    String? name,
    String? username,
    String? email,
    String? age,
    String? phone,
    String? password,
    String? address,
    String? photo,
    String? safetyNumber,
  }) {
    return ProfileEntity(
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      age: age ?? this.age,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      address: address ?? this.address,
      photo: photo ?? this.photo,
      safetyNumber: safetyNumber ?? this.safetyNumber,
    );
  }
}
