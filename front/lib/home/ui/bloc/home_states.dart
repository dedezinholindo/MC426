part of 'home_bloc.dart';

sealed class HomeState {}

class HomeLoadingState extends HomeState {
  HomeLoadingState();
}

class HomeLoadedState extends HomeState {
  final HomeEntity home;
  HomeLoadedState(this.home);
}

class HomeErrorState extends HomeState {
  HomeErrorState();
}
