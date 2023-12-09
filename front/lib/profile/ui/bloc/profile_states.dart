part of 'profile_bloc.dart';

sealed class ProfileState {}

class ProfileLoadingState extends ProfileState {
  ProfileLoadingState();
}

class ProfileLoadedState extends ProfileState {
  final ProfileEntity profile;

  ProfileLoadedState(this.profile);
}

class ProfileErrorState extends ProfileState {
  final bool isEditing;
  ProfileErrorState({this.isEditing = false});
}

class ProfileEditState extends ProfileState {
  final ProfileEntity profile;

  ProfileEditState(this.profile);
}
