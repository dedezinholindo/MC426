import 'package:get_it/get_it.dart';
import 'package:test/test.dart';

import '../src/authentication/authentication.dart' as authentication;
import '../src/complaint/create_complaint.dart' as complaint;
import '../src/complaints_map/complaints_map.dart' as complaints_map;
import '../src/home/home.dart' as home;
import '../src/profile/profile.dart' as profile;

void main() {
  GetIt.instance.allowReassignment = true;

  group('authentication', authentication.main);
  group('create_complaint', complaint.main);
  group('profile', profile.main);
  group('home', home.main);
  group('complaints_map', complaints_map.main);
}
