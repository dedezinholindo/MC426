import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mc426_front/authentication/authentication.dart';
import 'package:mc426_front/common/common.dart';

class AuthenticationApiRepository extends AuthenticationRepository {
  final http.Client client;

  AuthenticationApiRepository(this.client);

  @override
  Future<AuthenticationResult> signIn(SignInEntity signInEntity) async {
    try {
      final result = await client.post(
        Uri.parse("${baseUrl}login"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(signInEntity.toMap),
      );
      final body = jsonDecode(result.body);

      return AuthenticationResult(
        isSuccess: result.statusCode == 200,
        message: body["message"],
        id: body["id"],
      );
    } catch (e) {
      return const AuthenticationResult(isSuccess: false, message: "Não foi possível concluir a solicitação");
    }
  }

  @override
  Future<AuthenticationResult> signup(SignUpEntity signUpEntity) async {
    try {
      final result = await client.post(
        Uri.parse("${baseUrl}registration"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(signUpEntity.toMap),
      );
      final body = jsonDecode(result.body);
      return AuthenticationResult(
        isSuccess: result.statusCode == 201,
        message: body["message"],
        id: body["id"],
      );
    } catch (e) {
      return const AuthenticationResult(isSuccess: false, message: "Não foi possível concluir a solicitação");
    }
  }

  @override
  Future<bool> sendPasswordReset(String email) async {
    try {
      final uri = Uri.parse('${baseUrl}forget_password');
      final response = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {'email': email},
        ),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
