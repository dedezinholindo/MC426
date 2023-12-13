import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/complaint/complaint.dart';
import 'package:mc426_front/home/home.dart';
import 'package:mc426_front/notifications/domain/domain.dart';
import 'package:mc426_front/storage/storage.dart';

part 'home_states.dart';

enum PanicStateErrors { callError, sendPushError }

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeLoadingState());

  final sharedPreferences = GetIt.instance.get<StorageShared>();
  final voteUsecase = GetIt.instance.get<VoteUseCase>();
  final homeUsecase = GetIt.instance.get<GetHomeUsecase>();
  final getNotificationUsecase = GetIt.instance.get<GetNotificationConfigUsecase>();
  final sendPanicLocationUsecase = GetIt.instance.get<SendPanicLocationUsecase>();

  String get safetyNumber => sharedPreferences.getString(safetyNumberKey) ?? '';

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

  void sendPanicAlert(Position position) async {
    try {
      final result = await sendPanicLocationUsecase.call(LatLng(position.latitude, position.longitude));
      if (!result) {
        return emit(HomePanicState(error: PanicStateErrors.sendPushError));
      }
      emit(HomePanicState(isSuccess: true));
    } catch (e) {
      emit(HomePanicState(error: PanicStateErrors.sendPushError));
    }
  }

  void emitPanicState({PanicStateErrors? error}) {
    emit(HomePanicState(error: error));
  }
}
