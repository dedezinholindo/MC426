part of 'home_bloc.dart';

sealed class HomeState {}

class HomeLoadingState extends HomeState {
  HomeLoadingState();
}

class HomeLoadedState extends HomeState {
  HomeLoadedState();
}

class HomeErrorState extends HomeState {
  HomeErrorState();
}
