import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mc426_front/authentication/authentication.dart';
import 'package:mc426_front/common/common.dart';

class AuthenticationApiRepository extends AuthenticationRepository {
  @override
  Future<AuthenticationResult> signIn(SignInEntity signInEntity) async {
    try {
      final result = await http.post(
        Uri.parse("${BASE_URL}login"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(signInEntity.toMap),
      );
      return AuthenticationResult(isSuccess: result.statusCode == 200, message: jsonDecode(result.body)["mensagem"]);
    } catch (e) {
      return const AuthenticationResult(isSuccess: false, message: "Não foi possível concluir a solicitação");
    }
  }

  @override
  Future<AuthenticationResult> signup(SignUpEntity signUpEntity) async {
    try {
      final result = await http.post(
        Uri.parse("${BASE_URL}cadastro"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(signUpEntity.toMap),
      );
      return AuthenticationResult(isSuccess: result.statusCode == 201, message: jsonDecode(result.body)["mensagem"]);
    } catch (e) {
      return const AuthenticationResult(isSuccess: false, message: "Não foi possível concluir a solicitação");
    }
  }
}
