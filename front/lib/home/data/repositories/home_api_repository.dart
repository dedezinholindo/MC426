import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/home/home.dart';

class HomeApiRepository extends HomeRepository {
  final http.Client client;

  HomeApiRepository(this.client);

  @override
  Future<HomeEntity?> getHome(String userId) async {
    try {
      final result = await client.get(
        Uri.parse("${baseUrl}home/$userId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      final body = jsonDecode(result.body);

      if (result.statusCode != 200) return null;

      return HomeEntity.fromMap(body);
    } catch (e) {
      return null;
    }
  }
}
