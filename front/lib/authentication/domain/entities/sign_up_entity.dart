class SignUpEntity {
  final String username;
  final String password;
  final String name;
  final String age;
  final String email;

  const SignUpEntity({
    required this.username,
    required this.password,
    required this.name,
    required this.age,
    required this.email,
  });

  Map<String, dynamic> get toMap => {
        "username": username,
        "password": password,
        "name": name,
        "age": age,
        "email": email,
      };
}
