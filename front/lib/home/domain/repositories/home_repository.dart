import 'package:mc426_front/home/domain/domain.dart';

abstract class HomeRepository {
  Future<HomeEntity?> getHome(String userId);
}
