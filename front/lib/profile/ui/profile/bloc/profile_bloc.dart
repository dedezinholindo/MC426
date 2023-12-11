import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/profile/domain/domain.dart';

part 'profile_states.dart';

class ProfileBloc extends Cubit<ProfileState> {
  ProfileBloc() : super(ProfileLoadingState());

  final getProfileUsecase = GetIt.instance.get<GetProfileUsecase>();
  final editProfileUsecase = GetIt.instance.get<EditProfileUsecase>();

  var _profileEntity = ProfileEntity.empty();

  Future<void> getProfile() async {
    emit(ProfileLoadingState());
    try {
      final result = await getProfileUsecase.call();
      if (result == null) return emit(ProfileErrorState());

      _profileEntity = result;
      emit(ProfileLoadedState(_profileEntity));
    } catch (e) {
      emit(ProfileErrorState());
    }
  }

  void changeMode() async {
    if (state is ProfileLoadedState) return emit(ProfileEditState(_profileEntity));
    emit(ProfileLoadedState(_profileEntity));
  }

  void changeProfile({
    String? name,
    String? phone,
    String? address,
    String? photo,
    String? safetyNumber,
  }) async {
    if (name == "" || phone == "") return;

    _profileEntity = _profileEntity.copyWith(
      name: name,
      phone: phone,
      photo: photo,
      address: address,
      safetyNumber: safetyNumber,
    );
  }

  Future<void> editProfile() async {
    emit(ProfileLoadingState());
    try {
      final result = await editProfileUsecase.call(_profileEntity);
      if (!result) return emit(ProfileErrorState(isEditing: true));
      emit(ProfileLoadedState(_profileEntity));
    } catch (e) {
      emit(ProfileErrorState(isEditing: true));
    }
  }
}
