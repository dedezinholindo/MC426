import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:mc426_front/complaints_map/complaints_map.dart';

part 'complaint_map_states.dart';

class ComplaintsMapBloc extends Cubit<ComplaintMapState> {
  ComplaintsMapBloc() : super(ComplaintMapLoadingState());

  final getCoordinatesUsecase = GetIt.instance.get<GetCoordinatesUsecase>();

  Future<void> init() async {
    emit(ComplaintMapLoadingState());
    final coordinates = await getCoordinatesUsecase.call();
    if (coordinates == null) return emit(ComplaintMapErrorState());
    emit(ComplaintMapLoadedState(coordinates));
  }
}
