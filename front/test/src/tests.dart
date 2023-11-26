import 'package:get_it/get_it.dart';
import 'package:test/test.dart';

import '../src/authentication/authentication.dart' as authentication;
import '../src/create_complaint/create_complaint.dart' as create_complaint;

void main() {
  GetIt.instance.allowReassignment = true;

  group('authentication', authentication.main);
  group('create_complaint', create_complaint.main);
}
