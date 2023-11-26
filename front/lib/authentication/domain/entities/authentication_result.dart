class AuthenticationResult {
  final bool isSuccess;
  final String? id;
  final String message;

  const AuthenticationResult({required this.isSuccess, required this.message, this.id});
}
