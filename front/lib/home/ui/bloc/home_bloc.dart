import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/storage/storage.dart';

part 'home_states.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeLoadingState());

  final sharedPreferences = GetIt.instance.get<StorageShared>();

  void logout() async {
    await sharedPreferences.clearAll();
  }
}
