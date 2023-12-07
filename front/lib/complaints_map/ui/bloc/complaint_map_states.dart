part of 'complaint_map_bloc.dart';

sealed class ComplaintMapState {}

class ComplaintMapLoadingState extends ComplaintMapState {
  ComplaintMapLoadingState();
}

class ComplaintMapLoadedState extends ComplaintMapState {
  final List<LatLng> coordinates;

  ComplaintMapLoadedState(this.coordinates);
}

class ComplaintMapErrorState extends ComplaintMapState {
  ComplaintMapErrorState();
}
