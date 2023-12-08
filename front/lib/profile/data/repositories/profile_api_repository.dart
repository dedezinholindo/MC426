import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/profile/profile.dart';

class ProfileApiRepository extends ProfileRepository {
  final http.Client client;

  ProfileApiRepository(this.client);

  @override
  Future<bool> edit({required ProfileEntity profile, required String userId}) async {
    try {
      final result = await client.post(
        Uri.parse("${baseUrl}edit_profile/$userId"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(profile.toMap),
      );

      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<ProfileEntity?> getProfile(String userId) async {
    try {
      final result = await client.get(
        Uri.parse("${baseUrl}profile/$userId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (result.statusCode != 200) return null;

      final body = jsonDecode(result.body);

      return ProfileEntity.fromMap(body);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserPostEntity?> getUserPosts(String userId) async {
    try {
      final result = await client.get(
        Uri.parse("${baseUrl}posts/$userId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (result.statusCode != 200) return null;

      final body = jsonDecode(result.body);

      return UserPostEntity.fromMap(body);
    } catch (e) {
      return null;
    }
  }
}
