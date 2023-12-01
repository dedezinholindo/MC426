import 'package:mc426_front/profile/profile.dart';

abstract class ProfileRepository {
  Future<bool> edit({required ProfileEntity profile, required String userId});
  Future<ProfileEntity?> getProfile(String userId);
}
