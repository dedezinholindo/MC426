import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/complaint/complaint.dart';
import 'package:mc426_front/home/home.dart';
import 'package:mc426_front/storage/storage.dart';

part 'home_states.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeLoadingState());

  final sharedPreferences = GetIt.instance.get<StorageShared>();
  final voteUsecase = GetIt.instance.get<VoteUseCase>();
  final homeUsecase = GetIt.instance.get<HomeUsecase>();

  Future<void> init() async {
    emit(HomeLoadingState());
    final home = await homeUsecase.call();
    if (home == null) return emit(HomeErrorState());
    emit(HomeLoadedState(home));
  }

  void logout() async {
    await sharedPreferences.clearAll();
  }

  void vote(int complaintId, bool upVote) async {
    await voteUsecase.call(complaintId, upVote);
  }
}
