import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/profile/profile.dart';
import 'package:mc426_front/profile/ui/bloc/profile_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

class GetProfileUsecaseMock extends Mock implements GetProfileUsecase {}

class EditProfileUsecaseMock extends Mock implements EditProfileUsecase {}

void main() {
  late final GetProfileUsecase getProfileUsecase;
  late final EditProfileUsecase editProfileUsecase;

  setUpAll(() {
    final injection = GetIt.instance;
    getProfileUsecase = GetProfileUsecaseMock();
    editProfileUsecase = EditProfileUsecaseMock();

    injection.registerFactory<GetProfileUsecase>(() => getProfileUsecase);
    injection.registerFactory<EditProfileUsecase>(() => editProfileUsecase);
    registerFallbackValue(profileMock);
  });

  group("getProfile", () {
    blocTest<ProfileBloc, ProfileState>(
      'should emit Loaded State when the request is completed',
      build: () {
        when(() => getProfileUsecase.call()).thenAnswer((_) async => profileMock);
        return ProfileBloc();
      },
      act: (bloc) async {
        await bloc.getProfile();
      },
      expect: () => [
        isA<ProfileLoadingState>(),
        isA<ProfileLoadedState>().having((s) => s.profile.email, "email_profile", "email_test@gmail.com"),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'should emit Error State when the request returns null',
      build: () {
        when(() => getProfileUsecase.call()).thenAnswer((_) async => null);
        return ProfileBloc();
      },
      act: (bloc) async {
        await bloc.getProfile();
      },
      expect: () => [
        isA<ProfileLoadingState>(),
        isA<ProfileErrorState>().having((s) => s.isEditing, "isEditing", false),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'should emit Error State fails when request fails',
      build: () {
        when(() => getProfileUsecase.call()).thenThrow(Exception());
        return ProfileBloc();
      },
      act: (bloc) async {
        await bloc.getProfile();
      },
      expect: () => [
        isA<ProfileLoadingState>(),
        isA<ProfileErrorState>().having((s) => s.isEditing, "isEditing", false),
      ],
    );
  });

  group("changeMode", () {
    blocTest<ProfileBloc, ProfileState>(
      'should emit Loaded State when previous state is Edit',
      build: () {
        return ProfileBloc();
      },
      act: (bloc) {
        bloc.emit(ProfileEditState(profileMock));
        bloc.changeMode();
      },
      expect: () => [
        isA<ProfileEditState>(),
        isA<ProfileLoadedState>(),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'should emit Edit State when previous state is Loaded',
      build: () {
        return ProfileBloc();
      },
      act: (bloc) {
        bloc.emit(ProfileLoadedState(profileMock));
        bloc.changeMode();
      },
      expect: () => [
        isA<ProfileLoadedState>(),
        isA<ProfileEditState>(),
      ],
    );
  });

  group("editProfile", () {
    blocTest<ProfileBloc, ProfileState>(
      'should emit Loaded State when the request is completed',
      build: () {
        when(() => getProfileUsecase.call()).thenAnswer((_) async => profileMock);
        when(() => editProfileUsecase.call(any())).thenAnswer((_) async => true);
        return ProfileBloc();
      },
      act: (bloc) async {
        await bloc.getProfile();
        await bloc.editProfile();
      },
      expect: () => [
        isA<ProfileLoadingState>(),
        isA<ProfileLoadedState>().having((s) => s.profile.email, "email_profile", "email_test@gmail.com"),
        isA<ProfileLoadingState>(),
        isA<ProfileLoadedState>().having((s) => s.profile.email, "email_profile", "email_test@gmail.com"),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'should emit Error State when the request returns false',
      build: () {
        when(() => editProfileUsecase.call(any())).thenAnswer((_) async => false);
        return ProfileBloc();
      },
      act: (bloc) async {
        await bloc.editProfile();
      },
      expect: () => [
        isA<ProfileLoadingState>(),
        isA<ProfileErrorState>().having((s) => s.isEditing, "isEditing", true),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'should emit Error State fails when request fails',
      build: () {
        when(() => editProfileUsecase.call(any())).thenThrow(Exception());
        return ProfileBloc();
      },
      act: (bloc) async {
        await bloc.editProfile();
      },
      expect: () => [
        isA<ProfileLoadingState>(),
        isA<ProfileErrorState>().having((s) => s.isEditing, "isEditing", true),
      ],
    );
  });
}
