class SignInEntity {
  final String username;
  final String password;

  const SignInEntity({required this.username, required this.password});

  Map<String, dynamic> get toMap => {
        "username": username,
        "senha": password,
      };
}
