class SignUpEntity {
  final String name;
  final String username;
  final String email;
  final String age;
  final String phone;
  final String password;
  final String? address;
  final String? photo;
  final String? safetyNumber;

  const SignUpEntity({
    required this.name,
    required this.username,
    required this.email,
    required this.age,
    required this.phone,
    required this.password,
    this.address,
    this.photo,
    this.safetyNumber,
  });

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
}
