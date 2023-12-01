import 'package:http/http.dart' as http;
import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/authentication/domain/repositories/forgot_password_repository.dart';

class ForgotPasswordApiRepository implements ForgotPasswordRepository {
  final http.Client client;

  ForgotPasswordApiRepository(this.client);

  @override
  Future<bool> sendPasswordReset(String email) async {
    try {
      final uri = Uri.parse('${baseUrl}password_reset');
      final response = await client.post(uri, headers: {
        'Content-Type': 'application/json',
      }, body: {'email': email});

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
